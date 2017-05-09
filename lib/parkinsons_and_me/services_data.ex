defmodule ParkinsonsAndMe.ServicesData do
  def all_service_data do
    [
      peer_support(),
      forum(),
      local_group(),
      parkinsons_nurse(),
      self_management(),
      local_adviser(),
      helpline(),
      facebook(),
      newly_diagnosed(),
      early_onset(),
      publications()
    ]
  end

  def forum do
    %{
      title: "Chat online in our forum",
      body: "<p>Our forum is for everyone affected by Parkinson’s. Introduce yourself, ask questions and share what’s on your mind. There will always be someone to talk to.<p><iframe class='w-100' height=400 src='https://www.youtube.com/embed/zSsh0_Z7Ipk'></iframe>",
      cta: "Read some posts from others who are newly diagnosed",
      url: "https://www.parkinsons.org.uk/forum/newly-diagnosed"
    }
  end

  def facebook do
    %{
      title: "Join us on Facebook",
      body: "<p>58,000 likes, we’ve got ourselves some big fans!</p><p>There’s lots going on. We update our page daily.</p><p>Need us? We usually respond within an hour. Have your say, hear from others, and stay connected from anywhere, at anytime.</p>",
      cta: "Be part of our Facebook community",
      url: "https://www.facebook.com/parkinsonsuk"
    }
  end

  def helpline do
    %{
      title: "Call our confidential helpline",
      body: "<p>Sometimes you just want to talk to a real person. Our trained advisors and specialist nurses can offer medical, financial and practical advice. Give us a call on 0808 800 0303 or you can email <a href='mailto:hello@parkinsons.org.uk'>hello@parkinsons.org.uk</a></p>",
      cta: "Need some more info?",
      url: "https://www.parkinsons.org.uk/information-and-support/helpline-and-local-advisers"
    }
  end

  def parkinsons_nurse do
    %{
      title: "Get in touch with a Parkinson’s nurse",
      body: "<p>Parkinson's nurses have specialist knowledge about Parkinson’s. They provide expert care to help you manage your medication and support you in coming to terms with your diagnosis. They can also make a referral for you to see another health professional if you need to, such as a physiotherapist.</p><p>To see a Parkinson’s nurse you will need a referral, <a href='https://www.parkinsons.org.uk/information-and-support/parkinsons-nurses'>here’s a bit more information one how to get one.</a></p>",
      cta: "Find your nearest Parkinson’s nurse",
      url: "https://www.parkinsons.org.uk/local-support?op=Search&distance%5Bpostal_code%5D="
    }
  end

  def local_group do
    %{
      title: "Meet up with your local group",
      body: "<p>Going along to your local group gives you the chance to share experiences and discuss any worries with other people affected by Parkinson’s. Groups offer information, friendship and support, and many hold social activities.</p>",
      cta: "Find a local group in your area",
      url: "https://www.parkinsons.org.uk/local-support?op=Search&distance%5Bpostal_code%5D="
    }
  end

  def self_management do
    %{
      title: "Get training on how to manage your Parkinson’s",
      body: "<p>Run by trained volunteers who have first-hand experience of Parkinson’s, the self-management programme offers the chance to work through some of the bigger questions about life with the condition.</p><p>The sessions are for anyone affected by Parkinson’s and are free to attend, you just have to make sure you book in advance.</p>",
      cta: "Check if there’s a session happening near you",
      url: "https://www.parkinsons.org.uk/information-and-support/self-management-programme"
    }
  end

  def local_adviser do
    %{
      title: "Meet your Parkinson’s local adviser",
      body: "<p>Our UK-wide network of friendly local advisers have a broad range of expertise about Parkinson's. You can meet up face-to-face or chat over the phone. Local advisers can help you navigate benefits and grants, give you tips on how to deal with the day-to-day impact of Parkinson’s, or just be there to offer some emotional support.</p>",
      cta: "Find out how to get in touch with your local adviser",
      url: "https://www.parkinsons.org.uk/local-support?op=Search&distance%5Bpostal_code%5D="
    }
  end

  def early_onset do
    %{
      title: "Browse our information for younger people",
      body: "<p>It can be alienating and confusing to be diagnosed while you’re still working and might have children to look after, but we have lots of information and advice that will help manage everyday life with the condition.</p>",
      cta: "Information and support for you",
      url: "https://www.parkinsons.org.uk/information-and-support/younger-people-parkinsons",
      early_onset: true
    }
  end

  def peer_support do
    %{
      title: "Speak to someone who’s been through it too",
      body: "<p>Our free peer support service puts you in touch with a trained volunteer who understands what you’re going through. You can speak about all things Parkinson’s - from treatments to coping mechanisms - or just have a good chat and share experiences with someone in the same boat as you.</p><p>Call 0808 800 0303 and ask for the peer support service.</p>",
      cta: "Find out more about peer support",
      url: "https://www.parkinsons.org.uk/information-and-support/peer-support-service"
    }
  end

  def publications do
    %{
      title: "Start an information reading list",
      body: "<p>Our website has specific resources for people affected by a new diagnosis of Parkinson’s. We have videos and information guides on symptoms and treatments, as well as practical advice on driving, work and relationships.</p><p>You can download and print these off to read in your own time.</p>",
      cta: "Explore our information resources",
      url: "https://www.parkinsons.org.uk/information-and-support"
    }
  end

  def newly_diagnosed do
    %{
      title: "Tailored newly diagnosed information",
      body: "Our newly diagnosed web pages have the answers to the common questions that you might be asking too. There’s also advice on how to talk to people about Parkinson’s, real life stories and some helpful questions you might want to ask your doctor or nurse.",
      cta: "Browse our newly diagnosed web pages",
      url: "https://www.parkinsons.org.uk/information-and-support/newly-diagnosed-parkinsons"
    }
  end
end
