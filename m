Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B22192F4
	for <linux-cxl@vger.kernel.org>; Thu, 30 Oct 2025 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761785524; cv=none; b=RDWkz56YE4MHVNxMBA/jck/qj14bWUwIeAlKZH8BRkjysiFx4bQSscDPWhxKueeRJIbEoDOuRoEeANSPy21nY1DNhqLsUlsJnKYfYouECvwEbGlYo5xqJoQ1zjBg3StJvbTDAI92UJoGsg+V36ETyi+zPvgCtR9FqQAG4p8u80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761785524; c=relaxed/simple;
	bh=3PH/ZnMZdC8ZAvbplBJkffdi1dmMfCTRr8iJzYAGVpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DITv3ZP38c8pC0shnSnhGHWmAqNlunkMI/waQFBRMv+xzW58VJc5n8byKewjUXjmkbOUPUPqPOBPb9lXjRb6eKpeM6AMj+DzJkcWfuDUX8vIAqyXlnZQX0ZxinTw3vm8gcHn+ellFcEvl6ql+9xlAy+eHkY1uv2DhbNwsSD5a/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5KXmNFR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5KXmNFR"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-592fd97c03eso554046e87.1
        for <linux-cxl@vger.kernel.org>; Wed, 29 Oct 2025 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761785519; x=1762390319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6xYVmnl8b+pLdde1+Tw/tk8i/p4aUKZYm7+ZE7iZXM=;
        b=H5KXmNFRoVTBk4Fu4gxa3XGimJEMcm+s/SllTIwDx5XLCvu6ZK77NYGjAXXYucG7jA
         fJhR4MGafdRkoEK2bp/DzY4xtzMz8fEd/+CDRSHQiuRh81G1XzjPeyI/Aj+WtXGW8UCA
         2ZZxd+y5BshopX/z48VpEIo00g1JdV/fyDlkBBKMPJuAwhrE97Z+/32VUWwc4bWH5atB
         Q2U1Xhb6ejzwTdkhYRiwGzBWK7Qa+RdWwYBhvVmOs+9Jlf8kuvl5hv55dbPES4Um+UYe
         g7DFjhrlwywd3tZ7anCbR/m//fOLn4rFqU43D/m8Y79F2O+I1F76OHrzZxNu9zA2TC2Z
         qXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761785519; x=1762390319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6xYVmnl8b+pLdde1+Tw/tk8i/p4aUKZYm7+ZE7iZXM=;
        b=lY72Z1PQjYHoIL5LQt4gzw+myNMAnmyx5uR5zluvbRGBS3YivCK0Y1oBVCUvVKNHnn
         l6eyN2er52rWbfiQCKwAsLT/9frx/ucXQwm5IW2jGHAFBCjOkKklnLyAUbNLEvxRI15L
         G3iCNpVu/HrJYyaTojtVYp/tXrZpApsbMbOzKGt2cOcvhPyJzAgAH0f/sDjfmWf9b8WI
         jPYg/vxTwWquFeE0IUTVz3/m4GXWsX50//Weei/NY/fzq2jAT3PbkNEbhwnykjpSh/Pm
         tR1NhdIVE/CXvpF8MPNScCSrDj5ttOtI8fIuq2vpTFtQ1UOqYzPF4rEk+QyzpWCCbpRV
         Px1A==
X-Forwarded-Encrypted: i=1; AJvYcCW7L9mDvMYZWLZInTA9kXw5xIJa/pG1fxm5AE6tDkAdHtmKvIrChnBpcNho9aDpS86oyOMU6NIMYBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/edHeVN+2FGd8Bb1yM8YA2897VBBgZIy9AnY7XbIFenanrWRR
	SLTlCVWznmADkeUbhRdZEgKmkk2QrBe8OQ96Th8zZOr874Ho58blVWm/0h1J7Hbkp/SfF83yr9s
	m/HBedXkwP4+h5GGmK/XTFxO/Vd32af8=
X-Gm-Gg: ASbGnctxBPGlCRD/J8Mh8E/8LR9lgvKlnwwmadPl8ZgsfwDWMGLN/esRNvkXqufzmJ4
	As2wOJRQzJFvvKaWb3gNwKQhCCcw8mMPKpyr0QWTaxaleFmqtbuNnpFYv+H5Y7zMkGNgyazBLKl
	tgUxfSTuCzEE4wPk+FP34h21evZZM7FPmmWSZ5l6quJjNtXaVIUY29PG5aSp3pM20VFaaYvZyX5
	KiFGNcxFUJXdXaHLf36gNO6nGHH6Zu2J9FWe1+L8y4j4J0oTtW5no1e4S496IeQC3IGCUt9JMBI
	jxAbDdydJOA=
X-Google-Smtp-Source: AGHT+IFdZTj0Hn5lC/Vz33gkwcmYRndHSNkKnofFZ76z08Ze4hO5Vx8hhDcwQ0bao3VwybyT2E/0nhovnOfg+xF/7xA=
X-Received: by 2002:a05:6512:1326:b0:591:ec0d:3014 with SMTP id
 2adb3069b0e04-59416eec041mr325368e87.48.1761785518272; Wed, 29 Oct 2025
 17:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022135735.246203-1-akinobu.mita@gmail.com> <o3gxx5uipm53gccoccjjdvtvv6gkyx4r7qexzdkg3uqtqc7wsv@yd3rqfsy2bpz>
In-Reply-To: <o3gxx5uipm53gccoccjjdvtvv6gkyx4r7qexzdkg3uqtqc7wsv@yd3rqfsy2bpz>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 30 Oct 2025 09:51:46 +0900
X-Gm-Features: AWmQ_bnbvcpSgNqDHKvXq0v0UY_X1N9SKnYP2-HI_1FlJU2e4PFTlTI_Dvk-pEo
Message-ID: <CAC5umyiA+KkQNTv-mN=mA9BXHmqMH9Trr_07XYOh=QTLLm=zNg@mail.gmail.com>
Subject: Re: oom-killer not invoked on systems with multiple memory-tiers
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B410=E6=9C=8829=E6=97=A5(=E6=B0=B4) 4:54 Shakeel Butt <shakeel.b=
utt@linux.dev>:
>
> Hi Akinobu,
>
> On Wed, Oct 22, 2025 at 10:57:35PM +0900, Akinobu Mita wrote:
> > On systems with multiple memory-tiers consisting of DRAM and CXL memory=
,
> > the OOM killer is not invoked properly.
> >
> > Here's the command to reproduce:
> >
> > $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
> >     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> >
> > The memory usage is the number of workers specified with the --memrate
> > option multiplied by the buffer size specified with the --memrate-bytes
> > option, so please adjust it so that it exceeds the total size of the
> > installed DRAM and CXL memory.
> >
> > If swap is disabled, you can usually expect the OOM killer to terminate
> > the stress-ng process when memory usage approaches the installed memory=
 size.
> >
> > However, if multiple memory-tiers exist (multiple
> > /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist),
> > and /sys/kernel/mm/numa/demotion_enabled is true and
> > /sys/kernel/mm/lru_gen/min_ttl_ms is 0, the OOM killer will not be invo=
ked
> > and the system will become inoperable.
> >
> > If /sys/kernel/mm/numa/demotion_enabled is false, or if demotion_enable=
d
> > is true but /sys/kernel/mm/lru_gen/min_ttl_ms is set to a non-zero valu=
e
> > such as 1000, the OOM killer will be invoked properly.
> >
> > This issue can be reproduced using NUMA emulation even on systems with
> > only DRAM. However, to configure multiple memory-tiers using fake nodes=
,
> > you must apply the attached patch.
> >
> > You can create two-fake memory-tiers by booting a single-node system wi=
th
> > the following boot options:
> >
> > numa=3Dfake=3D2
> > numa_emulation.default_dram=3D1,0
> > numa_emulation.read_latency=3D100,1000
> > numa_emulation.write_latency=3D100,1000
> > numa_emulation.read_bandwidth=3D100000,10000
> > numa_emulation.write_bandwidth=3D100000,10000
> >
>
> Thanks for the report. Can you try to repro this with traditional LRU
> i.e. not MGLRU? I just want to see if this is MGLRU only issue or more
> general.

The problem was also reproduced with traditional LRU.
Here is a summary of the conditions for reproduction:

* Reproducible (The system becomes inoperable)
  * demotion_enabled=3Dtrue lru_gen/enabled=3D0x0007,min_ttl_ms=3D0
  * demotion_enabled=3Dtrue lru_gen/enabled=3D0x0000
* Unreproducible (OOM killer is invoked)
  * demotion_enabled=3Dfalse
  * demotion_enabled=3Dtrue lru_gen/enabled=3D0x0007,min_ttl_ms=3D1
