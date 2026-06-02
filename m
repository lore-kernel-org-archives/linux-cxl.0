Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D33D47BB
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393571; cv=none; b=fmlISAKorPWv08AQwH+fEHvu4JhWQ/H7ug6zawMya1L1aXUwyvIXqEkJ/mbKzkIQaUk210DIWMP0ALIPvRof6nWgdWPLQIvopCbictaTYg3xogQ9CVOVcWUKuYoqdfHyS6UHFO2cE2frS+ruqodhIq5ge6nEKMjvcWziK1z2MqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393571; c=relaxed/simple;
	bh=qwOzoxL1nfHFt1Z/yWF60fP6M1ITbnvyDCdRZEhb2vc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua24hyHu02hsQyOy5z8+Vm9FnwQ6fqoV0B2N3QFoeHuLElxyT7zwkpSsvbtdIm9iOW9GJ1AITKX5zKUbH1YcfPm9QbkO3axOo2gfnJhA7agHbO48vuqggkuNe+g1Whw50lmf4Go/JC/h6gEY74ajJN6zeXze2xMF28SkfVtlLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFjgIJ3u; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFjgIJ3u"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3042a388168so6282700eec.1
        for <linux-cxl@vger.kernel.org>; Tue, 02 Jun 2026 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780393568; x=1780998368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3lTY9oGN4197b14UYyts3x1t+0qjIngIJSSCllkUKes=;
        b=QFjgIJ3u9P+l1WFlm1CdhajWxGB/2iOyYQOQ32/ABn6sLHvz1hPYWQNblvjJuhlBV5
         J2v61CO4eouOui4IVBESnhFHrOjhP0It8ZhWAinzhJm48XfyMKuNvFIZuzEBKr1/kvzI
         mM36qeyRoRK5o+BYVsO0LPz53rkOMx5Ekrp5IsDx77PrwJ6V4j18Q2zs/2agjObu5Yf2
         MYH/J0lz1ygZrFmAPJg6aRHOBrXXNWVZKB5xCrzS0MiSkWy78nbw+KlXAjyGJcVT/z9P
         wIWZdA3S6Nuk+P8A9e37XgoEUNOpsEJI+tYPE8lGQi2SEilCYGFp/+uGCLkJ4cWp+fe7
         JoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780393568; x=1780998368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lTY9oGN4197b14UYyts3x1t+0qjIngIJSSCllkUKes=;
        b=AE8yTX+5p7UJw6Nxz5HOAUOL/+UdLMajQmIU+hEx5PbiJnX1RrrWKal5UIfvVfY/sN
         BPxBq9WTOF4hY4xmaafQ9qyan0wa1ic5rqBKs0zjm7/po9rEX30xe5I7amx6QK00fcbo
         UVwKTD6D163EuGW0Bv9vaewCXUsSwFRsmiC7qeZe3MyE05Y2KNwx7JTxhkJgOQGsM0GI
         DMHg+HA+wSyGs9Ncn2X/hs2CIM3i+Up9imKvcxXgcEExjjMk2l/RasiW9Lpd9FuYLI1g
         cohV0ZvlncI8lXgVZr9pFlzc/WNt16qGuJ8NOUa2PBwgOQBam4sTNHdozktMTPUOJOvU
         ubwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pdxV24C/gP1WAfn/PBs6TO/MKzkMweRddpZck4a1wDDlMY8UGE4drwQgmTWqyfbdCySFeFszxuPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPUfrhr+xGqEOnln3PM5b5yZNH1kynlBwLxVhnAgIUywvhyO5
	zBzrsnuBzZ6I4e3yM9fnw6mxhkpLULy1hftEgYtb0TIpQX6VTu/OzZdh
X-Gm-Gg: Acq92OGG8jwZ9i+2uD9Wsycs2wfq6MzK4ZBr+3sKw4yW85GZpRqBVHVDu6lDNVgY41w
	KRB3XrwJG+FT6bz7xmckyvIe11AWzj81HQfvEcpsVco69l4BqQAgb7ODgqCFt5WcfMPwUnNpSB6
	qR1ogPgssMOyazGCxP5mGBoM1BnuhY22CP6w3Q2/I/py0pDiGTcEVljDdBQ4Nb1OYggxRYKNHGl
	E3iZtjjoq6IJk6wc29IksY2dXYwamGYq4y5Z/KXkM2zOiwDkkJfcvKY+N1sY2S6SiRU9809zUnH
	GaiZnEBT82AFiMJdSOkoO7k5UxGmbZlHkHg2Z7D+7izsP1nkZyZThyDIcThW+bmOJV70cF4Gpnm
	P6WQfbpHWsuCRep/meXZCEcSGdbLJ/RdCyEFCwXPauxSVjT7W/TJGMjMqX+cTCxl6+AmML5yiXj
	H8Szljh2W5WZHxPJUhSj1/kPJ7Od+N8N+tpYMJ0dH18GPVQ4gXpr+j6BKYXrBIj2pKrCQCAjDyM
	2hAszwLM61MOlR3Aw==
X-Received: by 2002:a05:7300:220e:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-30734bd92efmr1546760eec.15.1780393568058;
        Tue, 02 Jun 2026 02:46:08 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm11088926eec.28.2026.06.02.02.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:46:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 2 Jun 2026 02:46:05 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 02/31] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <ah6mXWqTkooEoEKj@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <692890d6934d844cbbe90596499b28833e45f4f5.1779528761.git.anisa.su@samsung.com>
 <c250bffc-005c-4ce5-bf46-94219a7ba5b2@intel.com>
 <ahqGcScEzplyVSqw@AnisaLaptop.localdomain>
 <5def25f1-58ee-4bac-bc10-93492c1b1109@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5def25f1-58ee-4bac-bc10-93492c1b1109@intel.com>

On Mon, Jun 01, 2026 at 08:23:46AM -0700, Dave Jiang wrote:
> 
> 
> On 5/29/26 11:40 PM, Anisa Su wrote:
> > On Wed, May 27, 2026 at 03:28:56PM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 5/23/26 2:42 AM, Anisa Su wrote:
[snip]
> >>> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
> >>> +					kmalloc(dc_resp_size, GFP_KERNEL);
> >>> +	if (!dc_resp)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	/**
> >>
> >> /*
> >>
> >>> +	 * Read and check all partition information for validity and potential
> >>> +	 * debugging; see debug output in cxl_dc_check()
> >>> +	 */
> >>> +	start_partition = 0;
> >>> +	num_partitions = 0;
> >>> +	do {
> >>> +		int rc, i, j;
> >>> +
> >>> +		rc = cxl_get_dc_config(mbox, start_partition, dc_resp, dc_resp_size);
> >>> +		if (rc < 0) {
> >>> +			dev_err(dev, "Failed to get DC config: %d\n", rc);
> >>> +			return rc;
> >>> +		}
> >>> +
> > 		if (rc == 0) {
> > 			dev_err(dev,
> > 				"Device reported %u partitions available but returned none at index %u\n",
> > 				dc_resp->avail_partition_count, start_partition);
> > 			return -EIO;
> > 		}
> >>> +		num_partitions += rc;
> >>
> >> Would cxl_get_dc_config() keep returning 0 be a problem? Not likely to happen unless device is malicious.
> >>
> > Not sure but I added a check anyway. ^ See above. It prohibits
> > cxl_get_dc_config() returning 0 at all though. But could be changed to
> > err only if 0 partitions are returned X amount of times...?
> 
> I think as long as we have a way to detect that we aren't moving forward in this loop and need to get out at some point.
> 
> DJ
> 
I'll keep the check above then, and just prohibit returning 0 partitions
when the device reports that it has more partitions available, since I don't
think it makes sense for the device to transiently return 0 and for some
reason make progress on retry anyway...

But need to move it below this check

if (num_partitions < 1 || num_partitions > CXL_MAX_DC_PARTITIONS) {

so the no forward progress check is differentiated from returning 0
partitions.

Thanks,
Anisa
> >>> +
> >>> +		if (num_partitions < 1 || num_partitions > CXL_MAX_DC_PARTITIONS) {
> >>> +			dev_err(dev, "Invalid num of dynamic capacity partitions %d\n",
> >>> +				num_partitions);
> >>> +			return -EINVAL;
> >>> +		}
> >>> +
> >>> +		for (i = start_partition, j = 0; i < num_partitions; i++, j++) {
> >>> +			rc = cxl_dc_check(dev, partitions, i,
> >>> +					  &dc_resp->partition[j]);
> >>> +			if (rc)
> >>> +				return rc;
> >>> +		}
> >>> +
> >>> +		start_partition = num_partitions;
> >>> +
> >>> +	} while (num_partitions < dc_resp->avail_partition_count);
> >>> +
> >>> +	/* Return 1st partition */
> >>> +	dc_info->start = partitions[0].start;
> >>> +	dc_info->size = partitions[0].size;
> >>> +	dev_dbg(dev, "Returning partition 0 %zu size %zu\n",
> >>> +		dc_info->start, dc_info->size);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
> >>> +
>
[snip]
