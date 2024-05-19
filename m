Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D818638
	for <linux-cxl@vger.kernel.org>; Sun, 19 May 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716115034; cv=none; b=lg15o+8BF2UDnLEw0Sm7wLfllQVCrhRosEUM1Zi4KX6j4plTFpi1QuYkRTAw5c/RB73k7Vp+PQSGkXtS+n7hYc0gPllBu7jKvHN0t4I2WzpqBOxTQEDJOKm/d31pK8Wn2QdN0y3ZetTT6VKx2Ox1lsOBqeyymTqjN+tVT57r8uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716115034; c=relaxed/simple;
	bh=cfEirZjvI+7sS1CKNDle/rnvtxXHrXEhqBsbboraWPw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fQ0Qg0ndqIZldeRpe/40xMPv0CT8Gw3bnzpRLhVSUjfQRgVzXehlcirOnw6Hl19K8nfOl9lGBQXyWJyLafIa3jQJsyn3PmIlz9bLrjFtXvvLHdE+NWny7lQJ4Gxk3SX181wa6meHhytN5s4rg/EU6G4Oa1Fk8XLcDq7RcoWyP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=IVhq+7cZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="IVhq+7cZ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e716e302d8so11814801fa.1
        for <linux-cxl@vger.kernel.org>; Sun, 19 May 2024 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1716115030; x=1716719830; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLmNyXaOlcEu5SbXzuRXbuZrba6JZAOSjBVcvVaXvTQ=;
        b=IVhq+7cZiopeLvnUokO3TbovTo5wOfGj5xnd+XBD3OXaHBPK/gV5rikR7h9Kg6sksj
         3ogrcC88uN+nU0YfzEkXQHPLwYw6JyBsUWyBpGkuTAwiLsPlrlQfI03A1Wv49QQgiNJK
         A1arKJqif8kRxhjtD7QZf1r9V1EfSbfrJzrseq1wsOH8NKaoHmxLfbN6KO9OdrcOV+UK
         qaDoKQm7VuMmANJNuAS48QDiJgjN/VEkYO7mbi2+68++0EY+OZjWlkajTnkMkWrTndMk
         dT8vyj70mBOOIvM0PkquWU5v6Gv0pfCyYL+f55p240dG0PQQVCuJRHx/fYbaCEDwwZdt
         uz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716115030; x=1716719830;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLmNyXaOlcEu5SbXzuRXbuZrba6JZAOSjBVcvVaXvTQ=;
        b=ds3iwnXA6+uXgJM6gwiY1R6EM9KcvGLABrxUX1vr8mmQuwIgIqb+WVbvj+7NUQrubW
         tPzemHiO9mvZRQRoJkTSBItbUEdZznz00cGZSb65uymYF1t/fDundDhlTHpqhiI/B0P+
         73c8k30NiQLd58mEXtc4PPxaa2pTM2KhfFF/DjoU/wZoDkOMei8GSXpIKIRXZeKwpSIU
         exB1R/791+2o0ADGl7cDJ7qkGNKwwGdP+VjrKUw9rRREGujD2Ea7QERStdSHDL1V97uN
         FU+7NnIb6hzZUvJdGb6PqgfGxbd0+OGHSXCO2tgcO823/ZV3PIj4mh0c1WZZRAH8kJG0
         8Flw==
X-Forwarded-Encrypted: i=1; AJvYcCWvevx42PObmNlgahVjB6kzn/zkKLE+F6YiBaL+6KEl6Xq5hjen7rsWIFVUKMe/vp6s0Joa3Zd88M1xIHCVJ2JmP6rvXJX7LBXI
X-Gm-Message-State: AOJu0YxAqBPSRXOhVo/IvAoLNoWSS5hw3N/lD4WyZnKW0NoC8DBozf84
	lYWQwW3favSti0qCKky9mUepbloaHqdrN+xTl/Mg/e8O0rl5Yp87/03vWPlJb64=
X-Google-Smtp-Source: AGHT+IGD3wO0ydBAxxlvkA4miE1+LF/l7SGE6Vt5MCRiu9Xb9EU7ECTxmWTT1y93q+YRYuMk77eE+Q==
X-Received: by 2002:a2e:8045:0:b0:2df:7824:7d32 with SMTP id 38308e7fff4ca-2e5204b1e12mr168929241fa.50.1716115029910;
        Sun, 19 May 2024 03:37:09 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:ddf8:74b1:36e3:738e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d1515664sm30931751fa.93.2024.05.19.03.37.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2024 03:37:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Re: [Resend LSF/MM/BPF TOPIC] A case of a CXL compressed memory tier
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <29803911-8566-4fa5-b1d1-7e3def541d7c@nmtadam.samsung>
Date: Sun, 19 May 2024 13:37:07 +0300
Cc: Yiannis Nikolakopoulos <yi.nikolakop@gmail.com>,
 "mhocko@suse.com" <mhocko@suse.com>,
 Dan J Williams <dan.j.williams@intel.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Angelos Arelakis <angelos.arelakis@zptcorp.com>,
 "Weiny, Ira" <ira.weiny@intel.com>,
 "yiannis@zptcorp.com" <yiannis@zptcorp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5F5F6AE-581A-4B40-A651-F1EEC1F25895@dubeyko.com>
References: <CGME20240514114400uscas1p1e3b27c6da724deb16bf86e4052f29fe4@uscas1p1.samsung.com>
 <CA+CExOi4v_8KM1ZA=ou3uZjpJDnMrJSsCVoWJcoBqbAequzH0g@mail.gmail.com>
 <29803911-8566-4fa5-b1d1-7e3def541d7c@nmtadam.samsung>
To: Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)



> On May 14, 2024, at 3:30 PM, Adam Manzanares =
<a.manzanares@samsung.com> wrote:
>=20
> On Tue, May 14, 2024 at 01:43:29PM +0200, Yiannis Nikolakopoulos =
wrote:
>> Hello all,
>>=20
>> This is almost literally last minute and the work itself is only
>> getting started. But since I'm virtually attending, I thought to give
>> it a shot in case it is of interest.
>>=20
>> Background: at ZeroPoint Technologies we are developing inline memory
>> compression IP. Currently we are focusing on CXL type 3 devices
>> (memory expanders), effectively introducing a compressed memory tier
>> (i.e. fulfilling the OCP specification &quot;Hyperscale CXL Tiered =
Memory
>> Expander Specification=E2=80=9D).
>>=20
>> To utilize the memory saved due to compression, we oversubscribe the
>> Device Physical Address Space (DPA) in addition to some custom .io
>> interfaces. If there is interest, I would be glad to present these
>> APIs and how the host's point of view changes compared to a =
&quot;typical&quot;
>> memory tiering system. The goal would be to get some early feedback
>> and direction for our upstream driver development, before we start
>> pushing the first RFCs.
>=20
> I am interested in understanding the interfaces and how the memory =
will be
> consumed and presented by the MM subsystem. It is my understanding =
that
> we have a 30 min slot for CXL related topics open this morning. I =
think this=20
> would be a good fit.
>=20

After attending the talk, I think it=E2=80=99s really need to =
clarify/justify the use-cases that
could benefit by employing this approach.

Maybe, I am missing something here. But, I think that compaction scheme =
could be
a potential pain. I mean even one application allocates and =
deallocates/frees memory
very frequently. If we place several compressed data portions into some =
physical granularity
(for example, 4K or any other size), then freeing operation can =
definitely creates holes or
introduce fragmentation. Memory operations are really fast and such =
fragmentation could be
really significant. And such fragmentation could be more critical for =
the case of multiple
applications and multiple hosts. It sounds for me that this approach =
could really require
a GC  or a defragmentation subsystem. But such subsystem could introduce =
additional latency or
could affect applications=E2=80=99 performance. So, maybe, smart =
allocation policy can help here,
otherwise, it needs to introduce a really smart and efficient =
defragmentation or GC policy.
Definitely, it=E2=80=99s interesting problem to think about. :)

Thanks,
Slava.

