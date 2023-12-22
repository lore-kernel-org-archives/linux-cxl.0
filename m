Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA35249E5
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="TLuAxiJb"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e3295978aso2492795e87.1
        for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 07:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1703257823; x=1703862623; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhQ/XEmmEXLeuiXM3/Bddn4zy68/ON4Wk5f7h+64qNQ=;
        b=TLuAxiJb9D0+Wljh4axbNasEvHBLGxpkbn4PLvN0tAndEL0y0JvUQuD/Ndu3ZeYucg
         J1jEZ+JeOBI/JMrFJRa7YjgnwtZE/tn46bmZSjGqlPj2D9iv7usbnC5lIEweer5E/4wW
         yjw3n1OboeDMlzQ3E1yJyRxa450GIVeSXktl0NwfENn02VJ5uFqBo0UOSs1CKcZBaHQ1
         t2ykC3Q0pkI+7fyQG5oYjenlz49VBW5LNRnNrMe/R1x9dtlFq18gZthse5+J4Mwc2ouf
         uY64ZFlFZrC/Bf08l+1B3YH1mCdsT8a/7YEWGPbufp+57rtvB+KN9HKvoYi8xlbE7hmN
         1hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257823; x=1703862623;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhQ/XEmmEXLeuiXM3/Bddn4zy68/ON4Wk5f7h+64qNQ=;
        b=kf0Sq5VwOpA++4x0uF4IxXnXehT6L/kEF96xXwi1zTfHDXBFfSK3wdWjrQKeTtZFy3
         Jv5emUM7/6rHZoLd9boScQq3lQvIVgp9YetHEYpsWZmbQxvDrZFvvtrtrT2NK/mVGfoi
         WWAGINKyHdQURf9yNQWWJSN+cMGc8T+jodLFPBbZmi/sWjCUtNO1Y4o8dzIgt+Jb+Uh5
         bkhm/Hne9HFE99u/Bx1SvDWIs7MuJvuS0wZ5Y1n2An2n3IxRp2XEpLwLuHiWe7DDKWpx
         UItlh+AHXYZJtI7iCX7zi7J2iFwE5jsGndxuQWSRmM5a/Y/wkwKSiDjp9aZDSLCBeQB/
         iPNQ==
X-Gm-Message-State: AOJu0Yyl861dd3H0ctVEEF69Myzie6LE8Nd4QraPZwodry0AkbB1QuHI
	Zfot5Zcwu1I5N6uIMD48M8KNY1+EdKRxhg==
X-Google-Smtp-Source: AGHT+IHwcIYCSdFNGF/2YAkJMwFMiJMPWzZghYQoj2nnWf/JTpoVlBFJsoIHX2yG6Wi7mdTSTlwCuw==
X-Received: by 2002:a05:6512:3d88:b0:50e:3e3a:3d6e with SMTP id k8-20020a0565123d8800b0050e3e3a3d6emr951312lfv.110.1703257823108;
        Fri, 22 Dec 2023 07:10:23 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:81af:ea21:9e46:5992])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b0050e6780dbe2sm277882lfs.196.2023.12.22.07.10.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 07:10:22 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: [RFC] Do we need dedicated LSF/MM/BPF 2024 session for CXL memory?
Message-Id: <42978BEA-D194-41F4-A619-BAF02CE8F4FF@dubeyko.com>
Date: Fri, 22 Dec 2023 18:10:21 +0300
Cc: linux-cxl@vger.kernel.org
To: Dan J Williams <dan.j.williams@intel.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 vhache@rambus.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)

Hello,

Do we need dedicated LSF/MM/BPF 2024 session for CXL memory?
Any comments?

Hi Dan,

I believe we need some talk to summarize:
(1) what we achieved during 2023 year,
(2) what TODOs we have
(3) etc.

What do you think?

Hi Adam,

I assume it will be good to hear what is cooking on hardware vendor=E2=80=99=
s side
in the CXL memory area. Could we have some summary related to this
(of course, what can be shared with open-source community)? How do you
feel about it?

Hi Vincent,

It will be great to hear what is going on with CXL specification and =
which activity
has taken place in CXL Consortium. How do you feel to share some 2023 =
year
summary?

Hi Jonathan,

I think QEMU is important area of CXL memory emulation and testing.
So, I assume we could have interesting topics and discussions here.
Any suggestions for this? What do you think?

Thanks,
Slava.



