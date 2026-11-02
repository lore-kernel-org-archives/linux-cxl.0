Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622780;
	b=A5xmm8HneWau/FOI6qMAY6uQJyV07T/iAT5/7+h/S/gr8KmWZHVhSvwYMykx4jZ79Jg7
	 yKZ06mjwoAMJikJobOJ/094Om/1kodMFoHXNuGRQbIYHTO9IRnHwfWtYAGV73d7A/hQp/
	 UFtNBZoT0SBPCOv4q6q84yCEjQjM630OTYZAtVPQ4wLMCl0f7fTCd73l8liut1kdZnxvp
	 cbu5CJgWLKJ+sQHEypyYb0utnFnsR1BBeqwqCMFQ25Oor3YzspShhY/oxDdek7xNkuNOd
	 F1nafMy377lKUeU/rcha2aOnz0l7qBUW2jgqvefHfcW7RtxKJuF2lCpcbxIG9cNoMPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622780;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lu6jKVMmWomkYGOYdMnLmaub6He5lRxtqe+uzz2qc2Q=;
	b=IO7ltQit8zPhtaQJE+TH4LsIH9RJE5PzdXsigUx8t1/PNeeixQPonHthzLlpzVDlD1Mo
	 tiek7jcQ9vFOjX1kT+5kDojki6KSUp/Rc2XrbU/+lcxILqr2oNo89OaxwFwhjKZX2UsBC
	 zW+nIKQ2OiTV3opu6puEGEkFlNbKIC9uyQU/xBcAir6ldQtpmGCtKY/nmPfb1ORAoBgTE
	 8VraMGD4WUNjQk1RxkKwcQ5yO+IoqwWo4LSWMLdcyzfea9HyZ7dCaTfSxwXIpvHmV/mbQ
	 roOTranhUtLgEss8VJJZrcIgXddG87eU+8MdvkK7LxqX0JJ6THOuV5j+Ab3z5iPb8dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967160A261E
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 12:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A967160A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9eb579c0eso15018405ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 02 Nov 2026 04:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622779; x=1794227579;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lu6jKVMmWomkYGOYdMnLmaub6He5lRxtqe+uzz2qc2Q=;
        b=fcyUU6QI72EgDP+WlrNZ7HNh6VO31nlwkpooGHnSaWq05E5ntxLQ9BHsZ6kY+s8Peo
         sJ3tfArpDFES9PCJo1s1fTBE5lY4uR4Mu4MU+80YyskWksikNpYRu7xjdGleQw88ZDcL
         +bn39fY0B8llTfBvgYP59FdgSnWHoEnzOJ09OsQNfipGjbHQnyFkaZDglgX6BxPRvbjy
         CQzQwkx9hHRRTQVj28P5BZ2R4WnWjfaWpPl/wVQ5k+9WW5IfCUP+yqWCAgJILxM8kvGG
         LPRWhe9MhRPt/s7xQRpWV5L8ZhABMDKgWO1vOWs8q8TJT3eHlTFq62RTS986Iml05dFX
         J5ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxT/h1krlc7JsKfZ237FBX8PQJ5pF5E1Ky3VtzC5FbZRq9fzkfg+YAbHVbXs02AgVNpX6LFCV4nIVA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kJIuJrc2+jdvOHZW24BCR1UA8UyWzFUkeBLBLQox5WfSMJ8N2
	TYOlXt+BUHcobfAZo7uzRlsJKs6otKaADt3WGIig+qfDE/Q3dYKkYgrhICkY2hm9B7o7
X-Gm-Gg: AYBFou2nB+WgnNRE+1fvqMMEswf0rT0dELb+HcaF/1cHEV8uB7EWzM0CWVXRqkCuAlC
	4Qom6Ud4PZ9Q/Dz647pCq/qUejeGTQyMFIugGOEmJy0GJ4MBboyRYE7iSbSeubmL/WvcjG5Pccf
	J05NIevYzIU1JQES4TdPpRrumn/DTd4vVZR+QeG47zwvobvhB2L4JHa8TmeU2Wvqm8DyXsmHEjH
	1x3QXELrLyPibQ2hFZthylFGn60PgNdvrmODtShCfE6nNoQpCGmdGU8ENfMIm80bafYir4Ei/kH
	20HJpOWFQBroWtoNu5vZ+yB+34mPMEmvgh4tt4HP0asPWS48lV4ATXGrCvqTksCyHZ7tQcN9HyO
	JX+cv4r5lHynUkzZTfjCnpWCFmFaOTB4MGVPceul91A+CzirlYnUB+LEvRI96LmS4gSFoluAbWk
	H92W/+yTxKjabNqas5bU6rn/6hDESA/M7meQuOYWBRWkfXy0RggSFNyGponRWn4Owa9pxbBYsmU
	tSyGZ86iLWJdl/pgkg0XBdT48JwXW/7fOHOezoZ6wg0VaBFVadtv6oBH5PoPkAFi189gZndBVjJ
	+zqMYH4htzQEMbqiZl/4uvM/QfWpwG32SRawggMtyzO2EyMedmDG18lt3OOBBK95lkXiEOARZwL
	PQKdnHEMl4r9cpDvfBqLp0xGH0UY580oJ4yDaHkQ=
X-Received: by 2002:a17:903:2ec3:b0:2ea:7180:3aba with SMTP id d9443c01a7336-2eb364614b8mr88398755ad.39.1793622778961;
        Mon, 02 Nov 2026 04:32:58 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392492fbsm27101845ad.32.2026.11.02.04.32.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2026 04:32:58 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 2/2] cxl/edac: Mask DPA flags in the event record cache key
Date: Mon, 02 Nov 2026 21:32:39 +0900
Message-ID: <20261102123233.74598-r2-ai@linux.com>
In-Reply-To: <auhH_eBMYqFznZlM@MWDK4CY14F>
References: <20261101013418.87326-1-ai@linux.com>
 <20261101013418.87326-3-ai@linux.com> <auhH_eBMYqFznZlM@MWDK4CY14F>
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

Hi Richard,

On Mon, Nov 02, 2026 at 04:30:57PM +0800, Richard Cheng wrote:
> Maybe something like the following to follow the pattern of rb_parent
> hiding the packed address and metadata encoding ?
>
> ```
> #define CXL_EVENT_DPA(hdr) \
>     (le64_to_cpu((hdr)->phys_addr) & CXL_DPA_MASK)
> ```
>
> Or at least make it static inline.

I'd like to keep it a function so the argument stays type checked, as
coding-style.rst prefers for function-like macros. I'll make both
helpers static inline, which is what v4 does.

cxl_event_trace_record() in mbox.c open-codes the same mask. If a shared
helper next to CXL_DPA_MASK in trace.h is wanted, I can do that as a
separate cleanup so this fix stays small for stable.

Thanks again for the review,
Jongwon
