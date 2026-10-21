Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613941;
	b=Gzk4zhNUNk6T22x5f/Ma3QC5JgAVYBTOlw23F5kDVl5PdqWi5B5dXr+Uy62pBoVg0OGk
	 OSbH/ktSg4vQX/9fh/pozpOYzXa6uQhGFJwWJBj6fHQsqbH7ENb/h0ChyJ51a0WdvBaBY
	 pbvBrlrtX61XHgzysWkDW0dQseksdyX3YEVdqeTOLmSbF2Qx3svgliEInTf1jCCed5HJO
	 tDWkXLg2COU3ZblHuas9DkpuxATzs9+FI16kJiUvqCkLFVUm/LcGNlQrlMIZpikPE9Ol6
	 0cNIC+EcSZ8CHjLGXc7DWxMff/mPkrFuUeii56pH68rIZ/mXShU7i+eONHUhZO2Qnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=A7A3Qu4FeRo1KfTu4t3Hb9gLExSWYXnRTXONAqoE3Ds=;
	b=OvYCbwcCAGngxWVSxKV2SlG7tm6C4pu7MBAUxY4YRHn3UEevHoKw/wj2HzQyOQFJjGcU
	 O7r91YaqiEnQ34n/czsd5B79GKXbGqoNQyLl7XE3iH3bBvjxZXEId/sUjOKTql6XLy45f
	 a5eWwoXmc1+LjE0CcDCxE1pKTbFUVDm6YcC/0sgBOJpBYTcfy2OFCibSyq6nt5L1kXJ0k
	 wKyrCV341qrWIg80NPgQlSThiSXXYN7vW9ZRJ1QMF+bf+JVgNXbVPS9z0AML36RXWxd7R
	 utpySe5+mjDMYnjO3q4HQH8HZ8+LCxLkw1W8aCPYO76RBKTc7sCPr7+xUAv9gbPqZ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GVpPm9bc;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071C606A319
	for <linux-cxl@vger.kernel.org>; Wed, 21 Oct 2026 20:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7071C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GVpPm9bc
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1183549eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 21 Oct 2026 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792613941; x=1793218741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A7A3Qu4FeRo1KfTu4t3Hb9gLExSWYXnRTXONAqoE3Ds=;
        b=GVpPm9bc+zIPk9hn5LNpctKd9MALwZe4t9kAyynMR/UyShtLooLptrHIB1nyip76ij
         e0yqiaPmGpYl8xvlp352dmUwFkxYzbMNmT2ZLMglhApwLUibVlRTMuBXpDT9hfDob0Lw
         cfsl/2z9t9lJkKCJ+L/eJgNmICGJ98IOU2j7S91LqgUWx0k59mOwGEMbFvKFOOTrKCxD
         eYVJe9qDJiL0A5UYeMDsuXarkUsP3C0QbX+tzVqbyIjoqCtl7gm3pWKNO1GDLMGOdTVC
         IPufgah6it6sHqVuCdI1hdNDCWNGFyS7rNh1ijEDfIxbOX7/JpmK6n+qJ4R0PR9jkz4F
         LHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792613941; x=1793218741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7A3Qu4FeRo1KfTu4t3Hb9gLExSWYXnRTXONAqoE3Ds=;
        b=XQTwZrn8O/3HdtDifr82s5fVbHDRLse04g4WZIMwvjAz7VG2O2fbCBfgqIph+O5u++
         BDWpf8b1V5ukpna8KT4cMnAl/oKxkyso4QdTBWNUf/kuFPdrlMwHt+Assby7IRiypLDF
         ICpVQw7yl/V+TWYdn4+Nsg2hkUnMc4Hf9Dy2BcSTjurOFfr0XYv56IU1JWyp3cm9Kh9U
         B7enrrnch7/nwLRRFSfrFDBz+zR2sHvYTpJbYh/5hnBQ9I8u0o7RgLEFU1rvOgdtBFA0
         MJMX8h9Kp3wy/UvX1ooVscuXz6+HmwhgGxUB4cUYQnjNq16FbeeIhfFFJLvN80I3RbHb
         z7GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxonSyoDzQd3OQpCtwxEh1FG8pvKyB7mRoUQ9Y7y+Ld+QgwdecPBhK8DlX2Z2Y+hxvwqKuv6s0vBVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBjOH+TkWTWQJQkqpIvMQVtcYtgJzkSXyAX8rH7RqlHK5+icnR
	kq1WFQisgJMEfyFH1GlGtOnnNbPj02SBvAm4RvyAbRvzt4tqbq2k2vVU
X-Gm-Gg: AYBFou0d2vwjUFhvzwJZDStkZH46oBh81Wr644bc5/37LN57/voAdWLsiJsxeBI58Vj
	keJ4vLiYu/v0LLtLAgDWd/EiQjcRBD9BuTXCN4mgVvmP2FiCA2idBHD1BHVGQ2lTvk51nmDU8Gs
	CsvGxWiP+ksjOSkUtkFgS8uVPksAGgHuyJd+8gD0HudFACNiVokuhCrpe42SGOpULm7xQ3efOt+
	BXJjlFzTJDDUpzzb7Hz4RrNPCcqpCha6ZHhj5z1fB1jeK59tYkmalx7hxz6MzUNGcjZ1n8fvZQF
	y06Ox49AiavHEhbFoER6XDl3xTwmGNwWPcEFJmjC7i0hMquEkMW9h1n5tXbO9C+GbVbyUusQSPZ
	a8X2lkRuZ1XOFC2HIKv9IALAEhQ7HTs10fi05xrGbMgZF0Yu4BHfmQTLXvAWdwZqEFyP/Bqq18j
	Tb0zqo2SWdCEDkEG/1em8LBm0ct8ACmiIeK9jOdoBXWUe6gTirJYx59N7wLL05PcToVquR5LI8O
	QDsZPCZpjUmPcWD+O5Cc0jd3GgYL7D6DlWrOBy6pSAICEieNQldetWa5kTlbRuo
X-Received: by 2002:a05:7022:e1d:b0:141:4c37:a212 with SMTP id a92af1059eb24-190a051dd9amr5401751c88.2.1792613940370;
        Wed, 21 Oct 2026 13:19:00 -0700 (PDT)
Received: from localhost ([2409:4062:21d:8dc5:7fa7:1adf:a854:c40c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e4f2eacsm7986001c88.23.2026.10.21.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:18:59 -0700 (PDT)
Date: Thu, 22 Oct 2026 01:48:55 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 0/5] cxl, mm: Keep device-reported poison out of the
 page allocator
Message-ID: <atkeL1aBD9p5hQgN@acer-nitro-anv15-41>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <ata_pfACXdlQuM_e@aschofie-mobl2.lan>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ata_pfACXdlQuM_e@aschofie-mobl2.lan>

On Mon, Oct 19, 2026 at 06:11:01PM -0700, Alison Schofield wrote:
> On Sat, Oct 10, 2026 at 09:50:08PM +0530, Shaikh Kamaluddin wrote:
> 
> snip
> 
> > 
> > Applies on next-20260908 plus [1] v5. The num_poisoned_pages_inc()
> > change agreed for v6 [2] does not touch these patches. Patches 1, 2 and
> > 5 touch only drivers/cxl; patches 3 and 4 touch mm.
> 
> Hi Shaikh,
> 
> Can you share a public branch with all this code in one place?
> 
> -- Alison
> 
> snip
> > 
> > 
> > base-commit: a9d7ced84989ec05be09b4b8428759ef60450a0f
> > prerequisite-patch-id: fe9d44deb8ccc48c0311bc4131bdf733eb353b34
> > prerequisite-patch-id: 4cabe6adb37cd8c218bd43c97970bc65f313b671
> > prerequisite-patch-id: 52ad24bceedb9c03df167f10573166a1d97ba97d
> > prerequisite-patch-id: 44bfbc8aa3c4b19593f7b0d466fbc0cb99b99f76
> > prerequisite-patch-id: 2d344a5322ff07c7895a59d2425540a30e4e0630
> > prerequisite-patch-id: e776f306dcbdda3f6972187ad1e43a62c2754890
> > prerequisite-patch-id: 3ef887599e31ef973d6d9ca15d0462d55f5f0409
> > prerequisite-patch-id: a23fe88ab4529b6a6669a991e15cf1631311391c
> > prerequisite-patch-id: 111c69880ed0e148cdda285896c006e8d1fc98a8
> > -- 
> > 2.43.0
> > 

Hi Alison,

Here's a branch with everything in one place:
https://github.com/shaikhkamal/linux/tree/cxl-poison-rfc-Breno-v5

(top: 9e63fdb "cxl/region: Register device poison before exposing RAM")

It's next-20260908 + Breno's hwpoison-kho v5 + this 5-patch RFC,
matching what was posted.


Thanks,
Shaikh 
