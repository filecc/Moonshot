//
//  AstronautView.swift
//  Moonshot
//
//  Created by Filippo on 26/12/23.
//

import SwiftUI

struct AstronautView: View {
  var astronaut: Astronaut
  let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  var missionsOfAstronaut: [Mission] {
    var temp : [Mission] = []
    missions.forEach { mission in
      mission.crew.forEach { member in
        if member.name == astronaut.id {
          temp.append(mission)
        }
      }
    }
    return temp
  }
  
    var body: some View {
      VStack{
        Image(astronaut.id)
          .resizable()
          .clipped()
          .scaledToFit()
          .padding(.bottom, 10)
        VStack(alignment: .leading){
          HStack{
            VStack(alignment: .leading){
              Text(astronaut.name)
                .font(.title.bold())
            }
           
            Spacer()
          }
          ScrollView{
            Text(astronaut.description)
              .padding(EdgeInsets(top: 10, leading: 0, bottom: 15, trailing: 0))
            Divider().padding(.vertical, 5)
            VStack(alignment: .leading){
              HStack{
                VStack(alignment: .leading){
                  Text("Missions")
                    .font(.title2)
                }
                Spacer()
              }
             
              HStack(spacing: 10){
                ForEach(missionsOfAstronaut) { mission in
                  NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                  } label: {
                    VStack{
                      Image(mission.image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .scaledToFill()
                      Text(mission.displayName).font(.title3.bold()).foregroundStyle(.white)
                      Text(mission.formattedLaunchDate).font(.caption).foregroundStyle(.white)
                    }
                  }
                 
                }
              }
            }
          }
        }.padding()
      }.background(.darkBackground)
      Spacer()
    }
    
  
 
  
  
}

#Preview {
  let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
  return AstronautView(astronaut: astronauts["white"]!)
          .preferredColorScheme(.dark)
}
