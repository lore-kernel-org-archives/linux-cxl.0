Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098282BE11F
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151301; cv=none; b=cA2stUiqjJsid62yIvi2LFCn4x/YK68I5pt4QgSOUBaP0sOPII2BQ7lHIOGZlos3QClfgr0avbjW2On+rbcf1F2LRhYGk0ca+Jkh+wVeQeEUATRdkWniv8tlL+njDDYpi/77uYFqwvQ6T7rYSJ3HZZo4zVhWevmXq6QBIAG1mRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151301; c=relaxed/simple;
	bh=sySQufbkGVV2U7dyuiP5ybtkNQmnAIfWIWQFOimy/WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsFhHDwyIhCdb5UTYqxCpz9xi7gYQlEeVSg3DWmW7jj+dLzeNBPgAe+Fv93AWVEv0hafOpMLPEvUiwrGmBTSv1ZVe6/ONxC2Lpb2sAE2FdNOxRY4wzup/i6MRaUeSni8bVZEM4Fmbv9kk9EDWhx1rKpWxnKXRfttng2JK2ez5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KAoDvpym; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KAoDvpym"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5e2fe5f17so651057485a.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747151299; x=1747756099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bWyUH43trZ2uuzy2UVdfiNmXfRAjsML9dXQHFH2j/0=;
        b=KAoDvpym0hgx/saRvVHaa8E2QX6J36G2G8viOvFU0V7ie26nZIg5Ja4KJh2qM52z1x
         l9lpZxa8KCAGe3lku5GFfEVT0s2a4A3ZS5qpJNtwp7uz9JI9NJyfkK6U35TfxxguVe75
         EpPnDJDj1SJlvElYqRwcdiiSaEaQ0VMbXtgaZB+quSY11olGMVKPUJJI5xHa0qIrXNQ7
         4oa6Pw10QvcLk9AepwqHriaTDyoNDqdbFvKAkn+O/dFXE/a5OMw1GVU8uEnSYrIHoumP
         4qHziqjkijvx1xHm7G6ZKUwOvbuXSweClIg3ZLENy9jEEShoaPdSFk7kzRv9zvVKGMJw
         HZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747151299; x=1747756099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bWyUH43trZ2uuzy2UVdfiNmXfRAjsML9dXQHFH2j/0=;
        b=nvqAW2B4eQfO/vU2nz724aNEhLgGsEf6fBoNTPjh4IRrWf3+jKxo2SspW3YijGYjbw
         AGKN0M7xFwpXwS+42mPsOzoI5FzVfaIg3lUBh73G92JINuWfFceEOxg4Bni7Oi+BHLrc
         hNI8R24aJBlLBqAGZjoNEGTqmHWasnPNCt2gApG024dctV6zGhgXRVu0hUff6hUGeP84
         GQ1YQmQ62oC6bqx1C41UkAfDZVYLnkfmqpkqJ2elqZS1XM3xhOpcr8HYhc7RKY9wBP0l
         sq88gZrriVNi3sXA4H0Qq3FueikgTQ1g5+/iHUO0ApRZ//DOqO6Hm0bc+dHe7sXVNRXf
         JoLQ==
X-Gm-Message-State: AOJu0Yx5SRxHOPlgzKwTAh/8/7utXMEX60eSanf+R52d6N0+eAfI8h8d
	nKM0w9Df3O2yBhfULeJmxzudeg+l2OYP0p1HiZX+FBLQ4N0K++XjAbe6b2TGfsKakif+18JDy/v
	l
X-Gm-Gg: ASbGnctv0I9dObRiz3T40hL+G6IYOngmDWypRmhulTb7wG3kgAukSuCrpHCSjv7zzrT
	wH7NKAlyVrSXT7EEnUa8VZ+3x+EWBBVtLg1KkdncYK/FoftEMfQXvywUWB7kGUcOHK5+qcSPFXb
	vHlQMT7guMoDG5YYPYZF4SHvNF/CZNjfocXV4wS5tjiR9QKY1xl9UUIPIJr0nhL3bJoicxj5rDF
	CgNK3WK5JuhyAuW5hAB/TBkaVxJPlGG/NzZ9VJTiSLQxzaiPS4ZIFbklT0f+cVxPZj7DJW6Nmlm
	nf3LkRexYu6bOrgSZwPvYGeo7T7wkVqZU84uDWmJMyrpjnS7JJ8cJIr6NIGscysSh6Gzfp1zYQ4
	OTJ+49pcjN/ICDFpx1pgYKh2K1/jOgig=
X-Google-Smtp-Source: AGHT+IGAkf3bEdpIPKX3nWhUZRjBLyH/Y3zS9V+Q/IeIo9MC76oiAXm3JBiv0OmwpFR3UM+S/jtb2g==
X-Received: by 2002:a05:620a:2404:b0:7ca:f349:4265 with SMTP id af79cd13be357-7cd287df076mr9676185a.4.1747151298672;
        Tue, 13 May 2025 08:48:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fdc5besm719184585a.89.2025.05.13.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:48:18 -0700 (PDT)
Date: Tue, 13 May 2025 11:48:16 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 07/10] cxl: Change sslbis handler to only handle
 single dport
Message-ID: <aCNpwGU3d5Xr2qvb@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-8-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-8-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:07PM -0700, Dave Jiang wrote:
> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
> not efficient in the current scheme where one dport is being updated at
> a time by the memdev probe path. Change the input parameter to the
> specific dport being updated to pick up the SSLBIS information for just
> that dport.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

