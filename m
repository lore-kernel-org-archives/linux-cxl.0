Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925A1A3161
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966795; cv=none; b=dv9lPrpEytqv0j767i+UKC6CVBOMG9ZvQ8xY86M7QHpVpg5nWKA1kVmC4sCg3fta8uyeYn5BZjtLIUHUq9cwOQGIL8FM1Hpg+moOIj4YYbCvhoEJkKPLK6JACHqBxSdw6ElBPQcKqy9D9DgsEI2wfI3X3gERlJ71/71cTB0NjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966795; c=relaxed/simple;
	bh=ps5EjYggeB2pmCfRj5Y1qHEl1n/SHTtVyuqzfKf0ht8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me0WFFHTxe0O2Kv3yCz0sXAox9+hqwYsc6XKo4ub4HpGUhgwQG5M0l3Dvw/MnFZc0p4PRTxSR+yFh7Ohv/XJVmMqOXILkneVASTD8tDfm6aackv4BPu/JxNO9MvPPG0aISizNkREzR65r0Lv5JgHJcsSXevGSqmMM0vfRDkcmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ScZcY2N1; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ScZcY2N1"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd420f82e2so32251106d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 14:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738966793; x=1739571593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNYJ3hvEn3WHrM7IryEw3ayHWigT+bDMHa3yuIYsG60=;
        b=ScZcY2N15IHWTxx1YUi5LctkewctjNwvLcXxq9GP8s+82s7Mk5Ne0lkrlBJf+9AdCj
         b6g0YS8ZHUL3MNxGaMkeJvE+7hUVvopjH+pLIZI0itSWr2bDPAb7ABrtb8vbvvptGfEr
         GTuuuggOnXEUpEO5qCaSbGYay6wZQtvoyu2bKhgI1OkBOstmEfsmaTIuIHLQaIKB/aKT
         Pu2lfW2LlbjU1TNwoxgGjfXc9M4M1vMBj3DE7ejJ/WZ9omXbKXrdpcIpsEWlILF50wyV
         F0bkS+XXOHxvDmjkU3OEfYBqnkMMlBhCjpHZL9x9w3Hn6bHpiXxNQLOrxJH2hQbPdmvM
         /1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738966793; x=1739571593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNYJ3hvEn3WHrM7IryEw3ayHWigT+bDMHa3yuIYsG60=;
        b=i80CQ2LwkX1+TvjaYvFDLGuVtdFSOztmn8ruHcp0AJ7unJ8qywZs0veE/f8gOw1oCg
         qJIBaqDD6tF6Aqgh/Na2XIwys9QtczWV76CiNx6+TkYs0RA65JtFZlXYfSLkhTzigEWU
         2M+xbg4LArS1YpKORmlhRxXU1CQkJWMrtF8zKW6YIS5BaducmvwqlbC+4ixfPcvmvh0b
         k+v4eGCRTrygIE5V5tmuxB1C2DFcbJBz/6PFnyOehXZ7ap6a2Dzie9OiMwfZra5bOF0l
         EvIaEoiG76rD9YfZNsTsExkbcjfdV92git+tahZNy9Q8YrkTsrkkTa1hB8GZ1YeV4CmG
         DI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEWxTLp3UzUgK0n6Tk1eiNNgtMcqPvcnzNQPzOeHnWTw7959JxjE8JgC/JkY8ndN4J3KWCOc3zgUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTq/YWNPSbaxaQa1dKeysubK0ez9CfnJIplIrcKWAjIITj8Wq
	o+xCPwhHMfPh1omgDXORhFD5/+aEFCd77fvHB9N4f0ITPq2F++VrugOVKj6QcPM=
X-Gm-Gg: ASbGnct1T/4H6mNmc8rGzWwyxUxC6q62OHG0zG32Ok5kIa8WbVHy6K26zEHlQF8lSHl
	e14YkAfYxURjxdliEPHYtKQ834VLqqIAtTYx7OlVbPRXb7YlXXRWKS1EP7lsndxfVVivJ57uDXE
	CdimL9YZBUb8yFjZt9qxDSzCyPyBfqLyt7vH7WA4tfn+pbImZFW2W6WuIV/kGHN2UXRWSFm3CkA
	dPjakePtx1VGOFoSoekaNjJF2DHopm19tDbKwkMNS6Ij5oo3rN7nXBMaODD/UwfWOz9NXhdGqB3
	9Qll6Uk6BLXmzMZhTVaj3xVCxQaS/6nNoipR9XCOjGwrBdv12F0hfdWGQbiJlNkT/3z52HvvXw=
	=
X-Google-Smtp-Source: AGHT+IHuh8FZ1mgmCnMmsLjrt+LL4tFHjVCmaSizXKjRSMf8Fg3xlArwjI3h301vYadEZcBHltyvdA==
X-Received: by 2002:ad4:576b:0:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6e4455d2f32mr79737356d6.7.1738966793258;
        Fri, 07 Feb 2025 14:19:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43bad5a7bsm21233486d6.119.2025.02.07.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:19:52 -0800 (PST)
Date: Fri, 7 Feb 2025 17:19:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Jim Kao <jim.kao@xconn-tech.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <Z6aHBuGwuEMy6Kc1@gourry-fedora-PF4VCD3F>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-4-rrichter@amd.com>
 <Z6YurVy_K96jet3U@gourry-fedora-PF4VCD3F>
 <BYAPR06MB413558D98731EBD422CF24E4A1F12@BYAPR06MB4135.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR06MB413558D98731EBD422CF24E4A1F12@BYAPR06MB4135.namprd06.prod.outlook.com>

On Fri, Feb 07, 2025 at 09:36:08PM +0000, Jim Kao wrote:
> Do we have any limitation for HDM Decoder Range in Linux Kernel ?
> We has observed that Linux might be hung if range is larger than 8TB.
> 
> Jim
> 

Do you have any additional details? dmesg/core dumps, etc?

Seems pretty suspicious that it happens right on the 44-bit boundary.
