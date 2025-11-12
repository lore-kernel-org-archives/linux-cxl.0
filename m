Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F47247281
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986956; cv=none; b=fJp84WNt1yUwb7KQYHjBmMyswOwd6CW4jF1X53bsZ/yAGuSgoXFRLbetAMrHmIUoSbaqldesGr5hVIQZTEJMi55vmT90N4EPpWYKZHu3jmMCkdEz+fl9csdxfcaKIFNRkVkofJNEALFWCz9+1q1U6hB0a3f35wT3zV3I424Bv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986956; c=relaxed/simple;
	bh=QrFgy8kef1RTClQoguANzsfanj0qLkO8wMzPB/Oop2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJomBWlD64VBZ4axv1I9CG8NS6I+OGzEIA3xrh10J1IeMsO6QqrJX2v6xzh0x/dl/mCxpChoX+tCMP7JtKOkWB9YTLTFfFC6te0psP98sbnKqVSK8SrnD1iM2pI41qLta/oKjBHP8wg1w3nM24xQH6je3ai2PsC4r4SbeVVh4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AbZqB6Hu; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AbZqB6Hu"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b21fc25ae1so20456685a.1
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 14:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762986953; x=1763591753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SCRb0goywJQgJBdSKI77dEqVkqf5FzF9n7s1+P7Ecw=;
        b=AbZqB6HuGm6VuqZWbnMFo/gc7+e1z8j46rYYfZuqembi3g8lx0MCXFAroH8IK3EixH
         G0M5989MKnYeK5TF+o8edaBel/6iivfivkL5Yuv3+NxnxxuiB3khfBXMtIk3n0HL5u5L
         VMmyW1G5vmeGTIPnNJnpRQqJYDunYBy6z+uWG+bptPz+HnNPSoqFLq0yFR00wBUA8T9/
         8yeuVyUNbp5U7RdNpVXmclhUOv9tDS8gb/G40msmnLdDOv0lRkkoPfM0UI6k1MWPjiEL
         V8pjKk3ZAVx4tNC+r+HXpAX37KjwCYZC3xuHiRUOlYh5CoEwHXKxO3j2CzyZEP3/PjDD
         m97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762986953; x=1763591753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SCRb0goywJQgJBdSKI77dEqVkqf5FzF9n7s1+P7Ecw=;
        b=SElgP6SDlNw1dlC+7YCrL+a8T8sKwDtj732bDcZb/oWLqc7DHk4ZzZ1xOUdvqpYOn2
         VuddzsjiE0qxZ0p2wy17LyV5i72mzUeY6L0vwmo5FVGs+zJKlZNERhosxt18zx2yKuS5
         SAdsCHM347tUZyqiti9S21hj7U6w6A/aIa0Vp6XZ7lT53J31tRzpUc7Ou7eYOJYnqZ8R
         PLxf1fkaurfbzXRSqImwDLOW6qXME2uEwHwPTRLr+qBHvkRJG77R7UCYeBHpUkPK8Ws6
         n/5KNHJwHK7lKXdwPPzKBd5gDXvEd7fFQdPDSUU4SSevJlzam2AKmcbeBCFqXSvapgqX
         6Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPHv6jR6C5QferFq0iqNrwkeDm0bN2RqCoIklHQVa/xnAWBQbE4ljJ1EAYXPhUkNxbwiuIqV3kOmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxBrpKVxiYDt/ZXaicYDIpgRdY14oJUTty42g/5SZZJpKtRboV
	S98MeGWUZePoqhMwE0k090XvvedHKPTKEQ5EpdiW9/7nTafwQ6aCazZ9jUk6kariybA=
X-Gm-Gg: ASbGncuC9DpxrACjoR4i4syZu9y88wWTaE3l3oYASYESnJOI7UGDwkmbDq3xWlv478N
	2fXkKvprhldtew+i0lnHV0Z7z59woXvcTndziVJUhwbkVYKuWgFQRh/Xwg/mcetzB6vd37aPKq0
	nRNx3Su6gQ4gSKylIs4ku7ZMuHKoBDZp3Ozi4jXsGQrhKTE+BQQiV7j9YOTpoDSutHu7oa72+n5
	SVA5fYbLdia2JTFKsIfOw5zyJupAqAPJcOrz8j+3iPGC+/KpzgFYyxEENCZRtjskHvtnQyT7Ey2
	SgR3KKBHu3EBkRhGyF6TFsGTBG8VNL3OwVJ7w4kjrcwol/zlTAOtSEpa2lnsccCh0aGSozLbtdY
	CZfOT+CMiZpqqVM+P1GPWc9Rmcxj90p1TUJEHWPwsHlagO2/Spn25WNffTDjx4cTCExXp0bUHit
	jO0wZy8Io/s/df7M41a3AnEVL0P/Z1D6URRxPDooNwhR/Ebw9hC+mq2ag+coE=
X-Google-Smtp-Source: AGHT+IHWGpmoPeLN99RSRKB2vhWe71CpUl612R6GfVmHX8/+13R+ZA4bwWYytCuQvVanxwsa6ZIqLw==
X-Received: by 2002:a05:620a:1726:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8b29b764a2dmr589563885a.25.1762986953124;
        Wed, 12 Nov 2025 14:35:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aef2f784sm10061485a.38.2025.11.12.14.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:35:52 -0800 (PST)
Date: Wed, 12 Nov 2025 17:35:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 1/3] cxl: Simplify cxl_rd_ops allocation and handling
Message-ID: <aRULxsKoSTXZfPqN@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112205105.1271726-2-rrichter@amd.com>

On Wed, Nov 12, 2025 at 09:51:02PM +0100, Robert Richter wrote:
> A root decoder's callback handlers are collected in struct cxl_rd_ops.
> The structure is dynamically allocated, though it contains only a few
> pointers in it. This also requires to check two pointes to check for
> the existance of a callback.
> 
> Simplify the allocation, release and handler check by embedding the
> ops statically in struct cxl_root_decoder.
> 
> Implementation is equivalent to how struct cxl_root_ops handles the
> callbacks.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

