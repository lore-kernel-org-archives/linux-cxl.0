Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551AD57D20A
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064294; cv=none; b=CNPqhNL0Y1QakTFTSBzk6dyP/MtIZAhOWSIVEwS2xqZx+G/2Vn96QVi32jQ+5s5kQ9krPnap7tkHx9TSakWByML18bEG5LpoYPBaBMPlj0u7dxHl339W4mFM89ArWyHdLWVDaR7VWS5omxOhsAOqp3jEQP4a3GAtjngfUsmyQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064294; c=relaxed/simple;
	bh=9hXjfDNhKmYP4X+gkE3qOLuX4LWJOngTdWluef84ork=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Q+cdxCi92OOPcIjeeGYrUIGD7UZYdHKokhW//Pb/cFOcTX0xdWQd95NSM9H0lYOSEZ4hCOqXnWeQtkOAFrKuQwDGqSVNemcyiC9PvZFManeqkEwIOXJVZYwPmP4+3SxeIw5p8Q0Q82yxdgedfusd6N67tC9eHUq5kYV0BJrF5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TKsMv8Sd; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TKsMv8Sd"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260910181803epoutp01a8c286ee848918320ba6bee6f9b57e3a~UCHy3wT1r2643626436epoutp01T
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 18:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260910181803epoutp01a8c286ee848918320ba6bee6f9b57e3a~UCHy3wT1r2643626436epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789064283;
	bh=OQ0nhEhf/1R8uFnSN5DuKP2tH3ii5rke0Xx19jIH1kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TKsMv8Sdmb44or+EpYezS8OchnIYTR2858ZyNesBrwL4S/RRwtzbKbBdSYzX4Foyh
	 7lNo9E5Sxidd2LeRQhOmUZGzgqstrBF1VHYv6auvNKyTZbKUlAk7QM4li+y2Jw7dtZ
	 Z4TmGzDhwI4ZgBU8vAZJTQg4yHKRt1KEZH6EbpDY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260910181802epcas5p1a3e653ba2ab16e889be7aea053300505~UCHyMCUKs2653226532epcas5p1J;
	Thu, 10 Sep 2026 18:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hgmBL6p4sz6B9m6; Thu, 10 Sep
	2026 18:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714~T7Bmo1Rf82396323963epcas5p35;
	Thu, 10 Sep 2026 09:37:51 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260910093750epsmtip216a8b0f7cda3290126aecd781fe78389~T7Bk1WdgZ3127631276epsmtip28;
	Thu, 10 Sep 2026 09:37:49 +0000 (GMT)
Date: Thu, 10 Sep 2026 15:07:43 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
	dave@stgolabs.net, arun.george@samsung.com, dongjoo.seo1@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, cpgs@samsung.com,
	gost.dev@samsung.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, shrihari.s@samsung.com
Subject: Re: [RFC V2 05/10] hw/cxl: Wire UIO capability into HDM decoder and
 DVSEC registers
Message-ID: <937773018.41789064282938.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260830072118.399487-1-junjie.cao@intel.com>
X-CMS-MailID: 20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714
References: <1646464088.101787732103895.JavaMail.epsvc@epcpadp1new>
	<20260830072118.399487-1-junjie.cao@intel.com>
	<CGME20260910093751epcas5p34f8f8305b510015bc8f43c0ee7d9a714@epcas5p3.samsung.com>

------sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/08/26 03:21PM, Junjie Cao wrote:
>On the type list itself: 8.2.4.20.1 enumerates UIO Capable for CXL.mem
>devices, USPs and CXL Host Bridges, the Host Bridge case being the one
>that means "all the root ports within this Host Bridge are capable of
>routing UIO requests".  This sets it per root port instead, and
>pci_expander_bridge.c passes uio=false for CXL2_RC unconditionally, so
>the host bridge never advertises it.  On v1 I said a root port may well
>be intended, going off crp->uio_capable in the SVC wiring, but the
>enumeration above doesn't list one.  Is the root port the intended
>carrier?

Hi Junjie,

Thank you pointing this out. I agree that enabling UIO in Host Bridge
(HB) should enable UIO in all the root ports, but the challenge is that
the HB might not know which root port attached to it holds UIO PCIe capability.
That's why the implementation went to root port. Will extend this
capability field to HB (x-uio) in the next version of this patch.
CIIW, Root port is intended to hold the UIO dependent capablites
(SVC, 256b flit), so that eventhough the HB enables UIO HDM field,
the attached root ports can be checked for the PCIe capabilities before
enabling UIO in their respective HDM decoder.

Thanks and regards,
Shrihari

------sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_
Content-Type: text/plain; charset="utf-8"


------sqS1HhdduDW2nLZYQl-nXfubNT0qWDWm0NnJ2DYydRADAyyn=_1c79a_--

