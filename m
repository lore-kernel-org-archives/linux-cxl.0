Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7ABE61
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jan 2024 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="eUDfZT+E"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso8476467e87.3
        for <linux-cxl@vger.kernel.org>; Mon, 15 Jan 2024 00:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1705309086; x=1705913886; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU+B/jNsHlEjZ2wxoEQjvy+rYT/Hb6w67qSs5hOnuUs=;
        b=eUDfZT+EdDDHNV0r+krb3vhN8LmYmEfX24Mt1AtDXhGhZZr1UvVzvodLyRcB81AWXR
         7j96/TqvcHo0h7SOFINXo7pXU5lAHSSy8ANoCdlvVE7yE/OloXXQ/vHPDvODUcsc10Tq
         ZPK7QlfytZsLvGlxKlEkeGfzAhYv3g74kYtvD93Uwdp+5Y8j9OCCPpoHf4ngAyXP6nV6
         VmZrbbLzVm/XyyZJIG+iCnEJV7BC6MGRmAmcsyob3oIBSHkAjvKbh+8uZpCPVxvzr3lX
         0yj20jEG3GiZgGXzyM2nJ0FgFUVuzfNfea/PBvVGhs08d9TfId6NfqiSB7uClQKiIWlR
         krHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309086; x=1705913886;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU+B/jNsHlEjZ2wxoEQjvy+rYT/Hb6w67qSs5hOnuUs=;
        b=Hi7iewDb74flK0s4UFEDNn3c+AIIhLGucWktDchKOdRZrbAPdD3r08D4NKTmNM/owa
         Rya7LHpY/nmXg/5adPIn1H00iLLc5UBOk/XZqgW2v02MAL7skRXfo16FmqlXYZAM1PBt
         J4LfIUplkEYgwLsCE/qSFnz2736VJOnrAYfRyVbnQaryc0ggfuz/P+fjBeMFKp8VwPPj
         ayuTJlLm9sRG32AbwqCnIZdmOeetL006kBIQbyoAQzeUUSOJZ7etvQyDb0YG5W8CoAZN
         f2kLCwNTDc43F2nPBpTQOeVYwSJU7JuK19aWa7mQaez917s+JW2Uk+turFa2FiJcA2M5
         kS/Q==
X-Gm-Message-State: AOJu0YwGKv2bPjWAWFtMD8X3qCbXro01rZ2lsUPudrTTcxoD2bTlmDix
	TPPlBBXj/9ysg0MFzaTeAj6gGxQwqXBiwQ==
X-Google-Smtp-Source: AGHT+IESuALzmLsUGdarm4Ng9xOq0U5iFLAlxI4UzttZtg7Vr6aLtR8mjHVKPDDg4SrQ3Dzx+GHubw==
X-Received: by 2002:a05:6512:34d3:b0:50e:ea33:7f10 with SMTP id w19-20020a05651234d300b0050eea337f10mr1630837lfr.137.1705309085832;
        Mon, 15 Jan 2024 00:58:05 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:9dc4:3ef6:b46e:2d4f])
        by smtp.gmail.com with ESMTPSA id h5-20020a056512350500b0050e80d1d45fsm1113178lfs.143.2024.01.15.00.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2024 00:58:05 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL
 memory?
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <59dfe08b-cd17-410e-b549-7fb277340a21@nmtadam.samsung>
Date: Mon, 15 Jan 2024 11:58:03 +0300
Cc: Dan J Williams <dan.j.williams@intel.com>,
 Vincent Hache <vhache@rambus.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 Fan Ni <fan.ni@samsung.com>,
 Jim Harris <jim.harris@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A177BF8-36F9-4E7D-B353-404F1113ED0E@dubeyko.com>
References: <CGME20231222151028uscas1p1fa4d0282844f4aaa36b1133c5df17c9c@uscas1p1.samsung.com>
 <42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
 <59dfe08b-cd17-410e-b549-7fb277340a21@nmtadam.samsung>
To: Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 3, 2024, at 7:53 PM, Adam Manzanares <a.manzanares@samsung.com> =
wrote:
>=20
> On Fri, Dec 22, 2023 at 06:10:21PM +0300, Viacheslav Dubeyko wrote:
>> Hello,
>>=20
>> Do we need dedicated LSF/MM/BPF 2024 session for CXL memory?
>> Any comments?
>=20
> We are starting to spend a bit more time looking beyond the
> CXL driver code, specifically interleaving and tiering in
> the context of CXL attached memory. It would be great to=20
> carve out time to get interested parties in the same room.
>=20
>>=20
>> Hi Dan,
>>=20
>> I believe we need some talk to summarize:
>> (1) what we achieved during 2023 year,
>> (2) what TODOs we have
>> (3) etc.
>>=20
>> What do you think?
>>=20
>> Hi Adam,
>>=20
>> I assume it will be good to hear what is cooking on hardware =
vendor=E2=80=99s side
>> in the CXL memory area. Could we have some summary related to this
>> (of course, what can be shared with open-source community)? How do =
you
>> feel about it?
>=20
> I would be more than happy to give an update from a device vendor =
perspective.=20
> There were several public demonstrations of CXL devices in the past =
year and
> it would be great if we could get representation from other CXL device =
vendors
> to share updates with the community.

Maybe, do we need to share this as a special topic? What do you think? =
Let=E2=80=99s elaborate
some better explanation of suggested discussion.

Thanks,
Slava.

