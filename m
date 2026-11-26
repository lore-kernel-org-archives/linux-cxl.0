Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660596;
	b=QhyQfVB97FDvPhVRNud2LKxLS1zboSjpGHdLIT429epkz7THhPn90QHPPhlvhjVUsBRF
	 CHRqZ8j2i4wdzA05mtQKVI1XSvHvnlW0hHH0CT4LxXI8lbfJy+gtyMcSggtuD47EkBlq8
	 NtblO414fu46H1l5nG3/ypg0VQkKOmoYUwwWD3kgoLi/WrrApEmuQk/JPjgxKtj5M4TF3
	 quDlisvi2WPQZTtpr3J9Ca9neYHFwO9EwvFBjCvZ8FvElo5BHnCQfGUib25/oXUK31iUX
	 uIi6RpAykycpvwZX7pqqL4jLITj4enfUEDhsddychgWTFGyEVaJPyno7KLuUnOyLQPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660596;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=z10TiqzuITDCTYtzs59wQFiEMTJflteO0aiswGXuo5M=;
	b=W3ymdhXP56ak8sA/MavI4Fcps7K2Usbee4T0nVV3kkrrQ0YaLr80n6X+OlmhWTZ/hyq/
	 MZaB0Dc6R3tlVN0qSCT4EuT557noGw2HXHhh4C6o9S1yvrgYX8sCYurYtS8AVLI2WiGRd
	 DgDi34EMMC/8hKntf40tV6OgfkvNugsPSf0nEFADvX2kTJ0CZ+cxMqtkDPIZZLARrwPs6
	 /tOY5obTSRK/NsIOBabhrOMSK5cuf0czJP5OkDgO91YLVilcwodfEduTuFmlmGndQkEMj
	 BUr4UWZfnF0DMaqW6iQCz9zH2b3ZhAdeZQykBJYDUdHrYqeLvUdwjMkNY4rygoWoZHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFB606A32E
	for <linux-cxl@vger.kernel.org>; Thu, 26 Nov 2026 02:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BFB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386d1859e1cso1119491eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 18:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660595; x=1796265395;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z10TiqzuITDCTYtzs59wQFiEMTJflteO0aiswGXuo5M=;
        b=xF3NQGHLkpMkqYEIfug66+7vmxahajrd0rlZFdgvA+O1M0oYKfly3jyp2uAH8lafOj
         JpOUNfF9E//j7m1BIvm4f/VxtZLMqIzpRQmg2UF6Wv7Zs3YEsRnBS4VjkSyE4OJakWPo
         9lPgSY1xuLlNtGrBcuSGZh1eZ6t9O0/P3yVxAM5uZbWA6436oC+BwJlEm+eqgR4Bfvci
         e+T60/L0RlI4ll6/DlgpZ8lvMdKGzHs6bKKqbFUpLuV9Ai7Wzp+bFWXD4gHaDbl/+0W+
         5mw0S5eu6v6U1t2MZXpKuiZQcMAWcKGwa39kwMWiT1yl/k3OHGD3WBX63U+NXgE72EuV
         2VtQ==
X-Forwarded-Encrypted: i=1; AL+hErFvOvS+g2l+/hOXrby46/aCIIcnOzEJvx/YrIaGRhQj8jdWGDafWxBiW/Ucv9uAnRCYbvU1LXw+Nec=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HuVHSFF+LY/Vi59MEwisaGIeONZr2KnRNF+F2lJx/VQ4PCOdW
	2Lj8jxciezDotDsEcrcqzbh9j5blmBt0bjeEAmaoe9sfCnloT/KjjdZDUt0FADU+jUL7
X-Gm-Gg: AZFdTZdQtfnpHBlAyHPMgfNkaLUfzzpqYl8pxyACbp221H5iiNBDPIHJTiH8SLRoPZj
	YNuI20BlkrEWGrQpF6BRUrgLtnF+TZK/O561CpP3HeAhPkkVoIT20qqPhxgEqHF2hw5TEeOrG0T
	gslcoJMOZ3KE3hqVJH/ZNqBsYqFtLSqYpmDJpBIrE2TIzD4zzYoEYbvubIBNWs8aZzFYdNYnAV1
	AgzLuPVHY8XO94ULsqVH+IXV9ZjSShMqspyq9LDHATTCnMb3MMToBtYC5eRK46k4sS2FFlcXBoE
	58rL4iVPVU9kxJvyYPMbs7D8KJ0shb5GJ2b6loH89y6IcVMGl9HDSvylpWrBuyhKJTn09Hhl/Vh
	e6wC/5qKQqgku9L+7Qk2+4bPFmEiDwgk2bwCqtNDLIL969kBDQVHOmTkeu3o/SKF+0Ps5fP6SfL
	wXr6hRZ0hbZGBOvwVtCob3C+d9MqXtBcOdadg6mkxY2laxTQjicQjnX1ofEUfCQ3ShmqU92aeDq
	DXtInS80qJa40N4GwiHbvKoxdj55JGmw1XtKezCFs9WXS7/OvyuhLDzJUtZ+XnnCjLAm9FcLAie
	m0ufIzmD/DilTfwEExuauPDBIxVsEtsUJzx72TzDCzTU6/4hNQ==
X-Received: by 2002:a05:693c:811c:b0:386:ddd5:14e2 with SMTP id 5a478bee46e88-386ddd52196mr840587eec.0.1795660594957;
        Wed, 25 Nov 2026 18:36:34 -0800 (PST)
Received: from alanui-MacBookPro.local ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26703230eec.27.2026.11.25.18.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2026 18:36:34 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cxl/edac: Read cached DRAM event records under the
 xarray lock
Date: Thu, 26 Nov 2026 11:35:31 +0900
Message-ID: <20261126023520.39368-r2-ai@linux.com>
In-Reply-To: <20261117013521.5b4d034a@jic23-hlaptop>
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-2-ai@linux.com> <20261117013521.5b4d034a@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 17 Nov 2026 01:35:21 +0000, Jonathan Cameron wrote:
> As I just sent to next patch. It would be nice to have a guard()
> for these. Maybe it is worth including as part of this.

Thanks for the review. I answered on 2/3: since this patch has Fixes
tags and is likely to be backported, I'd rather add the guard in a
follow-up than make the fix depend on an xarray.h change. v6 keeps the
explicit xa_lock() and xa_unlock().

v6: https://lore.kernel.org/r/20261126023520.39368-1-ai@linux.com

Jongwon
