Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799C37FF5D;
	Mon, 12 Jan 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240954; cv=none; b=YaM7lu6ol3MHKoLHgUC05tKu96Le2KLkj1Sxn2+nnbNvNOZzfkF32NzAIfbvCjZXOBC61baeanT/n+GRHs5+CXlGJgYcKV1DR6skg2/Knz6cnTawxlLa7fYnDneoRBM0yg5gHhrjl9XgjZDPEXUHiydrHjvanyfL9QnfkID1DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240954; c=relaxed/simple;
	bh=vM7cmFRdHgs9dzpK8DC6Y+MKvAhQWxrlxw3L1Rm7EnQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lvsBM2MABh88Co5p8NiLV60606+Nq5W2Afp/PaLZxdabXR9pXIoeaW9Ieqv2uhs5QJv4ZXRhNfjht44+0QGdNwujm9REzVm2HpkA0XkcbhCUpT0bPexQcH0Z/FqnTm/KwEOqsXRi6fM5bti6djrC9kUiQWBhR/XYomqiLzGZHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qD3DeD9y; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qD3DeD9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768240942; x=1768845742; i=markus.elfring@web.de;
	bh=vM7cmFRdHgs9dzpK8DC6Y+MKvAhQWxrlxw3L1Rm7EnQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qD3DeD9yNcE01C3zQ5tqLDDDKcT24x5JsKcxAOeaKtKh3pRfK22O8wxHIId57Ox+
	 5aWBnQKWLw8HNGMUTEEyu60hUoaoj+DDuTaEMEcuwpLVimcYp/hX+U66x9YqG2Ona
	 vJPw78VqEU69ksv+uCeWXtJEks3U+FzcMEAblA4Kude0IiNgqQCWzwgS8ycaUQGCV
	 Mo3OOftQRyLeYicFDg7Fza7N90nEFMvyid1rWnnUdDwOvj8Dj4Mqz1P0aMFZpk2vw
	 /3zJp/PNhJ1ShlPw3mBUWnLbMrLQRkDQn6CZmTlmzG5YszDUwoIRQN1HtAN2i7xyf
	 o4vdU7di3TXiQNgkrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.241]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRM5-1wKS5h19Id-00oleR; Mon, 12
 Jan 2026 19:02:22 +0100
Message-ID: <a1477c3b-f73c-4cb3-983d-c1690861449f@web.de>
Date: Mon, 12 Jan 2026 19:02:15 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dave Jiang <dave.jiang@intel.com>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <24ee9955-518d-4254-a961-3bf6a2d90840@intel.com>
Subject: Re: [PATCH] cxl/hdm: Fix potential infinite loop in
 __cxl_dpa_reserve()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <24ee9955-518d-4254-a961-3bf6a2d90840@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:neUWT/fe+c2tiqvutdSXQiBZXHdPAmCtYYmm/K9d6/1zAmF2/JO
 n+DrLD5v/cSmcproMJnPrc3z7FgSnAD1lVV0mvKI/FHWsZudmDrK7tdiXgqhqyTTFI/lSQS
 81djyGE+p3PR8NYSomPESsiH4zQNPd1cqdzqebYhP5cPkvias8111/kzYT+PQL5VCuM4Ke1
 /ifzP/TfphmGC4fL61WqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ufbCp2dFhbc=;GJcYBEJxx+1Z443LUc5M5hmeieQ
 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
 TIbjdeFU=

> > In __cxl_dpa_reserve(), it will check if the new resource range is
> > included in one of paritions of the cxl memory device.
> > cxlds->nr_paritions is used to represent how many partitions informati=
on
=E2=80=A6

How do you think about to avoid typos in such a change description?


> Applied to cxl/fixes with Fixes tag fixed
> d4026a44626490dc4eca4dd2c4d0816338fa179b

Is this adjustment still improvable?

Regards,
Markus
