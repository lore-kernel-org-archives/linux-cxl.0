Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1362690F0
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884128; cv=none; b=YsjkDPqWp4DmajQhnMP+kY4oOijKskMz4ygOjUreb8B9HGppiMxtuS/xe6Lxu283s15pc2vSEI6VEE5oVVV6vCq/KKELkETDdLjeI23UunBKKKOQm9bKoGD4qvJ1Q5ds+YtqBogmeQx+4Uq0cRe3iL6j2rC0AyfnHFMChJ7eK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884128; c=relaxed/simple;
	bh=HPDzCwQbaj/df6/ADC5zGbw7wwOPAh4iSEDcZas6KIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j10rml5DIPRBbeQO4W3WWFuP0mNC0Sral5YfqN6y6g3O+A16TxLWARf+sps8l5mfGocf3ZTS8x8BvZiVr6KnF8wYsHZuLQ0n5WmoEz4JsKVYIFJNxM/Vh4/hDe2Ty8pojGXDOtkz5nqF3y7i2XC23eKItEPvBrsiugo7Yb10HkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ePgxiZE4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ePgxiZE4"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c08f9d0ef3so69523285a.2
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741884126; x=1742488926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xNl+N7q/9OaetzEUva/jSWqSKwZzi+icZYg2l4BR/w=;
        b=ePgxiZE4R+c4SB8PWOTCty4MqsDCdtvABFirjXAcmiY9hmiHUTse01fRwfeCjyofpd
         sCTNXTt97Zadvs9IUA3GUX5rSi94lIJyWni20EYjrAsDQf80Dtr/SPBHQDDBNbj95OZE
         IoeHBRkdBYociSij3i23MYeY/W9K+jkZLt5hCpd7wGMfLEHekbW/H/X0jAetHWcuwQHO
         HY2EHc379OBcpkwTFZm1sT1uWNpMSuk84HJ8ea5pZ8FYuGV1LB6Klny7JLg5bYJIdvBf
         DVPpz5dpv5LXXVrI8MKJVu7ZBiF0SwlYNXThV9s2vba2foZjusGK1LMyEfr+Fh0AA7oW
         /5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884126; x=1742488926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xNl+N7q/9OaetzEUva/jSWqSKwZzi+icZYg2l4BR/w=;
        b=QmjipEQqqk3HTmCpr9S1FrRo2fv7DNMvGYTPSA7lxZkWLNcmH3NJPKraj8eZ0cO7dV
         qh/CseM1g0R0JhXfBkJ/hEKWkiRdw+V4zEX+04qS301njTHB9I/h0B2yQVO0zhbVa3bi
         pqnRBQPAS5Pf7r9Y3Sl7b7HcYxfxvaB6OFpIi1+KhDi0L+hLM9p7MlG9DNxn0gS7zuEK
         05DcZn0KKnL2XS2pScbkjOAFxO5KaPKr2qc6dQrN4VkQ1P1aBQxHHYGlTaeX/2ZOQoX0
         HrYCwJ8BIEEnN3uVs5/MgMRgbvGHzxKr3peXbCFExjZ1ly6Naq8uV2nqPh6A9tu5ocw7
         fyog==
X-Forwarded-Encrypted: i=1; AJvYcCWmfotDZDyDVSkqhSrNVqYdyXGtYyMxGnByVBLpCsxjrEqkB0ZLpf364rUJxOJq4GOc8YJWLoWnwRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxjd2MRYIjm5T3fMCUwcw8y2Pg1Faa/GeG7YzROHQEFgU9XZA
	FMVZJRiTZXQxMJCNs8yosV89a7byto1lROGkDE0tHxkLa2MPonkawgiuF/wRVecHQZZceIGDrdt
	n
X-Gm-Gg: ASbGncsDjMKV/yPK9jRtr5TlcERAQ6ku7QnMfUkk7XSeQjuHQmTFCFpzqDf8AYVy7e7
	QJj7U5t9b9dfouf2oTubTRyxcV/W1xnf57lz2Q/+oz5wF//RR77e6yS9SlaHNLjLdd1kjpeDaLY
	5RU/J3rDzCapQvQFKno+XnRSsZPZ1T2yrHjOqifv2A2tyb+wg+nvi1NrpgulynOydtkwCqYEpsS
	rb51aR0/d/CLCbSP7wkCpINuVGNI7W0095UXsletkFY6VyDDxlI7GenJynsi7gcKDzdZd2uFR7d
	u+mLv7Ix3zR3URApLqnan1c5ThuzQwou7GTTERaOqQeSfdlee+imNCZs+DCwRgEu1I7bZR2/0Sa
	ic4Qdca0E0Wd0eFoW3SqQ4EwDpaE=
X-Google-Smtp-Source: AGHT+IHaB5FwZypTre9bnElu4UDtRtYp5sIvDPiHQLQTt/iuCUfLb7vvYamZOzrYkeW67XJ4d1mSDA==
X-Received: by 2002:a05:620a:800f:b0:7c5:467f:d131 with SMTP id af79cd13be357-7c579fa4e92mr61386685a.36.1741884125950;
        Thu, 13 Mar 2025 09:42:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9d8absm117900385a.55.2025.03.13.09.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:42:05 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:42:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 4/4] mm/mempolicy: Fix duplicate node addition in
 sysfs for weighted interleave
Message-ID: <Z9MK235uVDmK1oYB@gourry-fedora-PF4VCD3F>
References: <20250312075628.648-1-rakie.kim@sk.com>
 <20250312075628.648-4-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312075628.648-4-rakie.kim@sk.com>

On Wed, Mar 12, 2025 at 04:56:27PM +0900, Rakie Kim wrote:
> Sysfs attributes for interleave control were registered both at initialization
> and when new nodes were detected via hotplug, leading to potential duplicates.
> 
> This patch ensures that each node is registered only once, preventing conflicts
> and redundant sysfs entries.
>

After looking more closely at patch 2, this seems to suggest we're not
understanding the OFFLINE/ONLINE events well enough to use for this
purpose.  I think this patch won't be needed once we address the
concerns in patch 2 - and more generally if we discover it is needed
this should just be rolled into patch 2 rather than kept separate.

~Gregory
