Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FD139CE4
	for <linux-cxl@vger.kernel.org>; Tue, 14 May 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687038; cv=none; b=Mi6MdglvQ+tCCwHwbPm63dKiZXPROOlMivzL1RQoWsCmikDJlEkGtsRya9hcwhZmDPLfsSx1U32HD64XDhdJB2zJUeXJYXAARsr2IDmXXXN+MHHJrMK2jD/Xd37smrJDLmCSVIV/P0nkEcYBsontJzcYS3GDTrUZwrnlQhilmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687038; c=relaxed/simple;
	bh=++Wz3kAVOglOqAxgvDgP0/SIapJMNfCQ9gVdB5o9DEE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aPVRgUgcbGqAO4Oh46lLrKei+NfnHlpJTZ7MLOr5cXgQx0ybDuTUpPf2CvUAILdY+YmB6pPU5l31H12fkE5qlIcYI05MGhyb18WKGLk1UuWlMpp3YeAA54OBWkqnMBB9GvR8pCTI2muUOrMuyQcJObJKeAPO1i3ay6zNs8Y+zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD4Z9STd; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD4Z9STd"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b433dd2566so4279189a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 14 May 2024 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715687036; x=1716291836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=++Wz3kAVOglOqAxgvDgP0/SIapJMNfCQ9gVdB5o9DEE=;
        b=WD4Z9STdpVT+DKhNpMSnSPWrTWl0tPy2EaNxudiIBlaTdJ6ZhF68U3cU43FlBTd8rg
         B4+f2GmbWHo3d+/xfhaK3VOBJsGYWG/wAYcHHGINN2bmfQRjye+FqwSfoBz3Ai71zZ46
         VfZC5EmUe6TgYGaaHNX4WNH9oKZYH15EF+PJDwIuXqMOGvypO5LK06CgCHjipAHvaCE8
         l6zuYupCIUSdilkQswt3bUyynNQlnvsycj5Y1yYN+w+jughDS2mYsXefl26KiHD2Bw9N
         4FWNdN9jAkG/iIk4RehDhoBemQGmogJpDp3ZrFZOgiXam4lhAg67md5zkN/BGFfdai6+
         +BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715687036; x=1716291836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++Wz3kAVOglOqAxgvDgP0/SIapJMNfCQ9gVdB5o9DEE=;
        b=lglQiDNazTFkkC6oAF+8kQO+FiN58PrFG1iKHERb3hmTYIp236RDkcDXLTSojfDZww
         wCUkQgHBZr2kn95GF3OLNXJpAWNPXiwTTimWYEHkx5FTdXNQvswaJjTA3/Dfn8z2xPUD
         34OGw6A0r7XAVgNi/GzGzXxtxiBSnj5r/N9IMuVUr+HJfMlsMq6jYs8ISBTQjOn/tMbr
         xChL3VyY/npW88UVZQ2j+s29rg+lHt1hT8jJwtA/HxgGxKb5PN1AbEIPmxPukeH6j9g7
         GgurVAgUJly7AZKrVssT/HQFoSqhvUi2geUw1S5FMBZ0jy8vpolb/YBq4cYefE/tqz2m
         WYcw==
X-Forwarded-Encrypted: i=1; AJvYcCW/8IVUhyR/4VIg7nAzSPJ3Zhboue5KRfS5ehvgJl4vjeyMIQfdEuf4ho1UZ6XQno84QAAG1mzUWlNvvYPxvF/lT5MwMhoiOQYa
X-Gm-Message-State: AOJu0YzlaOphZgR+LKNi8uYQe9jQp3SMqWe1VlVEnY9nsMwHG3/RVzdg
	GShCgBffQhfUmH3IbneqwQwcChGlp37+yn+tet7tX+DKFJxWMhnny+CM+/YI2H1uPRai+ySTih9
	eTLCf1FFuayn3/SlSyih5B1OtmDc=
X-Google-Smtp-Source: AGHT+IH+1RU0jOWz6nZZuVvYChShlcABOa7P6wNxDPyuKVWUdagfuhwH2aYos/RHy7AcbofBWAHS3xGoz8gANZzEGWM=
X-Received: by 2002:a17:90a:7789:b0:2a5:f70c:9ec6 with SMTP id
 98e67ed59e1d1-2b6cc97d18fmr10630655a91.24.1715687036248; Tue, 14 May 2024
 04:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yiannis Nikolakopoulos <yi.nikolakop@gmail.com>
Date: Tue, 14 May 2024 13:43:29 +0200
Message-ID: <CA+CExOi4v_8KM1ZA=ou3uZjpJDnMrJSsCVoWJcoBqbAequzH0g@mail.gmail.com>
Subject: [Resend LSF/MM/BPF TOPIC] A case of a CXL compressed memory tier
To: lsf-pc@lists.linux-foundation.org, 
	Adam Manzanares <a.manzanares@samsung.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Angelos Arelakis <angelos.arelakis@zptcorp.com>, 
	"Weiny, Ira" <ira.weiny@intel.com>, yiannis@zptcorp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending this from my private email to make sure it conforms with the
mailing list etiquette.

Hello all,

This is almost literally last minute and the work itself is only
getting started. But since I'm virtually attending, I thought to give
it a shot in case it is of interest.

Background: at ZeroPoint Technologies we are developing inline memory
compression IP. Currently we are focusing on CXL type 3 devices
(memory expanders), effectively introducing a compressed memory tier
(i.e. fulfilling the OCP specification "Hyperscale CXL Tiered Memory
Expander Specification=E2=80=9D).

To utilize the memory saved due to compression, we oversubscribe the
Device Physical Address Space (DPA) in addition to some custom .io
interfaces. If there is interest, I would be glad to present these
APIs and how the host's point of view changes compared to a "typical"
memory tiering system. The goal would be to get some early feedback
and direction for our upstream driver development, before we start
pushing the first RFCs.

Best regards,
Yiannis Nikolakopoulos
