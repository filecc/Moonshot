//
//  MissionView.swift
//  Moonshot
//
//  Created by Filippo on 25/12/23.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
  
  let crew: [CrewMember]
  let mission: Mission
  
      var body: some View {
          ScrollView {
              VStack {
                  Image(mission.image)
                      .resizable()
                      .scaledToFit()
                      .containerRelativeFrame(.horizontal) { width, axis in
                          width * 0.6
                      }
                      .padding(.top)
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.lightBackground)
                    .padding(.vertical)
                
                  VStack(alignment: .leading) {
                      Text("Mission Highlights")
                          .font(.title.bold())
                          .padding(.bottom, 5)
                    

                      Text(mission.description)
                  }
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.lightBackground)
                    .padding(.vertical)
                HStack {
                  Text("Crew Members")
                        .font(.title2.bold())
                        .padding(.bottom, 5)
                        .padding(.top, 5)
                  Spacer()
                 

                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                 
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                              AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                              VStack(alignment: .leading, spacing: 10){
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )

                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }.padding(.vertical)
                                .padding(.horizontal)
                              }
                                
                               
                            }
                        }
                    }
                }
                  
              }.padding(.horizontal)
              .padding(.bottom)
          }
          .navigationTitle(mission.displayName)
          .navigationBarTitleDisplayMode(.inline)
          .background(.darkBackground)
      }
//  INIT
  init(mission: Mission, astronauts: [String: Astronaut]) {
      self.mission = mission

      self.crew = mission.crew.map { member in
          if let astronaut = astronauts[member.name] {
              return CrewMember(role: member.role, astronaut: astronaut)
          } else {
              fatalError("Missing \(member.name)")
          }
      }
  }
//  INIT END
  
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
