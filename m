Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C1317173
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046842; cv=none; b=ClmTwrtRMi3VjwOF9b9tlz2yNzpeJ3xbytm9r/RF5mHHL428ER8QOD+NnjYJ5/zf7VtqJHhpD7MN8Oo+7ApzMBdZ95mZSzK+8VzOTx/YsGP7VH64CrB57vG8HR1LaALJ65rddU1vZqxCTsTFz+T3nduPFKasVrQMczqygCGTalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046842; c=relaxed/simple;
	bh=EZuJZyB49vzCq5f2gxGBEUTba/nL8HcHJ8rKioa30dk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nI53wZe+DnaaQZALIBV5f1dt0Up5tqzq8jYX+0x1U3Q7RTgLAKHmWj4/oTs0QQE2+vF2rfBhg+3U6PIl7Y8DJbQZRpVzQywmHPV47K/7c+8cBd1GZCW1zRSGUUUIoyyywZQ9+YkU57I2BsTwAwVvf1osb/vaufHMfZQJg54LTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5l/m54i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5l/m54i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959851F00899;
	Tue,  9 Jun 2026 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046841;
	bh=EZuJZyB49vzCq5f2gxGBEUTba/nL8HcHJ8rKioa30dk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=i5l/m54ioLNngWB7os/uojy/5YEYuvwcY+uD1ostPMHZiyuulRJA3Y4DGKwgpSkXN
	 aIH3d0XFrLH+FVRVmMUDoY0qojeW+0gfNcHv24fsG0Q2YybcuGbsU7LP4ZXNK/+VF2
	 1KCpgn1meYhAYXOWB8+uEInWsUmiUZ8Z0xwka37OaAUK8q35uo3kuHKCm1xQPcJ4rg
	 3o80QjHwI9ri4JCn2npOl/5BKCopBbhOicM04YYyM5JOetsoETlT5OHRYyCms9+6Rm
	 obKcBApMEYH8gNOkITerT9Ujf37vJQWqfBCXSklYguEgfwtF3tWpkhzC9/4463hS4d
	 uBb5/vjolq/1A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E9BA9F4007C;
	Tue,  9 Jun 2026 19:13:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 19:13:59 -0400
X-ME-Sender: <xms:N54oanPLv6fpjzP0T-_lFeCXYKJRL5OK16sct-LD3P7FvCJY9cawQQ>
    <xme:N54oarU93dZQs93w78yP7bY0Wve-w7na8pVboV_oYjT3mKMkbzOqEFZxPL-5YulUq
    kGEzV8pcIQbyANOrSTN_8vzh1wsLjUkSfWwdl0ZeYngDp22XMTQQ5c>
X-ME-Received: <xmr:N54oauwhf-qbxaAQPa5vGKt-RmZHNJAcnECmW3I2Ozoz6ytvChzQ3weLTV1riVw4AGavaLuX6LxOMMZFVbBNKAUg0FK20fRoFwg>
X-ME-Proxy-Cause: dmFkZTGg4LH9bTFwJQ3HNG/z8EqUcRTE/RvTsSkOXChXBK/8Uod2T+pVOiZXiaRzlcmXrM
    7ce1+8f9HCtwGnaXKzuyEPymIahvxAjaeD6IYR5sa1eEqyzkucphp1kmZJVkzjfG3F+cfP
    xl1hQmHo/C+WbGfVgzO9HTYPAFBqPWeM5l9IrMwcheD/DXLHQ6+VO/cswIr1W2tchNLy45
    WSZ4J89/kgyK6VVZjGEaXMSJ2HCVqbf7fXlAVpWTQF0VsuOCFAcafKXPM6aqiw7tut1/HZ
    oGDLtOWn7V0Jpad9HaSKaCHD4Cl8pwJF+EXRBo48YsdlDR7Xmv+QNXF8isABKHcpqt7gY/
    Ef2yxUHXua2O1pB7JP1P4YsCmKBuKzQzZwVDq7riWUz0U0/2kAJg8Er5kurwGVXPnnferj
    4cAd8AwSFHQLy7gf9L3M/D7pFFYw8LEqmib4ANKpO8QEOQlQKfLRbZaJg7GoR/+6ol4WK0
    jck0mKolwJH9CuRR6N1CYbT6ALpMcK/K/mB3Yf9ronbPyKAtUuF21GaGKw7z8AYOHtcJs6
    MUidKfOI/B+qt2FsjnU10Dk6JB/SOBPQU8RN14kx4d1JIGKqpnJRauWeODIiLyM/N7fpTg
    6eVo2J+OvgD48fFTLlCjFB8mMYvC88dQJYz/SB4zZgfkpP63C1TlhCUyqXEw
X-ME-Proxy: <xmx:N54oarP3YzrmJTNgFVIrmmjzLcAyuFhgjvUO9r8PvDAZZWZ5v6LHCg>
    <xmx:N54oagpPzB42MzbTLluY6wAw8LjpQvSp4sgrN0VjFfQnKUZaaM8LuA>
    <xmx:N54oai9tuuLMQ5nnioFzhnAnuqMw3XDSQokzrK8-IqeqcSBX6fOt9A>
    <xmx:N54oam1ZwipknKcgM1bC6csUch-0fugJ2Fjj5PBlbql6M0w5qd3zRA>
    <xmx:N54oalDA2BCdHJfDKT3CZk0RGUfRJ97YXdLBRosi0Bq6QFkQNS7KE2I3>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 19:13:59 -0400 (EDT)
Date: Tue, 09 Jun 2026 16:13:58 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Richard Cheng <icheng@nvidia.com>, 
 dave@stgolabs.net, 
 jonathan.cameron@huawei.com, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 ira.weiny@intel.com, 
 dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 newtonl@nvidia.com, 
 kristinc@nvidia.com, 
 kaihengf@nvidia.com, 
 kobak@nvidia.com, 
 vaslot@nvidia.com, 
 smadhavan@nvidia.com, 
 Richard Cheng <icheng@nvidia.com>
Message-ID: <6a289e3665fc5_4fa78100b1@djbw-dev.notmuch>
In-Reply-To: <20260607081345.61954-1-icheng@nvidia.com>
References: <20260607081345.61954-1-icheng@nvidia.com>
Subject: Re: [PATCH v4 0/2] Support zero-sized HDM decoders
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard Cheng wrote:
> Hello,
> =

> This v4 continues Vishal Aslot's "Support zero-sized decoders" series [=
1]
> and addresses the v3 review of patch 1's port->hdm_end handling [2].
> =

> CXL r3.2 =C2=A78.2.4.20.12 and =C2=A714.13.10 permit committing an HDM =
decoder with
> size 0. BIOS commits and LOCKs such decoders to burn the trailing, unus=
ed
> slots so the OS cannot program regions through them, e.g. a Type 3 devi=
ce
> in a Trusted Computing Base (TCB) established via the Trusted Security
> Protocol (TSP). init_hdm_decoder() rejected these with -ENXIO during po=
rt
> enumeration and aborted the whole port, so affected systems showed noth=
ing
> under 'cxl list'.
> =

> Patch 1 enumerates the decoder into the topology with its HW-reported L=
OCK
> state and skips the DPA reservation it does not need.
> =

> On port->hdm_end (the v3 review): v3 advanced the watermark for the
> zero-size decoder. sashiko correctly noted the write was outside
> cxl_rwsem.dpa, and that advancing it without a balanced release strands=

> hdm_end -- cxl_dpa_free() returns early on !dpa_res, so it can never be=

> decremented past the zero-size id, breaking LIFO teardown of lower
> decoders. v4 therefore does not touch hdm_end at all. The in-order chec=
k
> in __cxl_dpa_reserve() is its only consumer and is never legitimately
> reached past such a decoder: the burned slots are trailing, so enumerat=
ion
> reserves no committed decoder after one, and the OS must not program a
> region through a locked slot. hdm_end stays at the last sized reservati=
on,
> which is accurate. IMHO, if a non-trailing zero-size layout ever needs
> support, the check should key off commit_end rather than hdm_end,
> out of scope here.

I am not comfortable with this outcome. It assumes that zero-sized
decoders are always committed. I would much rather keep the meaning of
hdm_end as the marker of the last decoder set aside for a reservation.

Consider the case of a zero-sized decoder in the PMEM partition with the
RAM partition not fully allocated. That decoder would have a non-zero
skip and zero sized DPA allocation to arrange for the next decoder to
start at the beginning of the PMEM partition. Otherwise, it would seem
to need more special casing to understand which decoder is responsible
for carrying the skip.

I think the way to solve this is something like below (untested). It
keeps @hdm_end aligned with the available decoders, and tracks the start
of zero allocations relative to their skip. I believe it may also
address the Sashiko report.=
