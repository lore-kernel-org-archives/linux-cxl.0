Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536A1189520
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945747; cv=none; b=S3rsO1K7sXeEOwaYWEH8p2+0WjSjGpWdSY8JhZFD4FTCzWUSms9WVkIig1SPq2pc64oanz89sG+AxMoY75SwHi/T0nCWJ+g5P2ePWoqi/dKwpXyjTjOsrVDjpdwC9iZKxSai4r28qKHdP1UjHaKJC97y8iSp4n4gF2k7WJlUWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945747; c=relaxed/simple;
	bh=XaErmJGNd3qnIEy9xm5OsxWh5sNMP7wTJqbrGvV6l1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqnFtejiV5h4kL1Vlo5xVwTh8bHW2EDMu0BEOR7gqIyORv3bcOBVS/zmn3x0Ma3t3WSPIP+uJdCvcRbqLvT0mFFhUSXFmCxEriCmYZzk+W0+DTx4sSOsB0aquX3jrNzCd2lhLjI0o5O6d3c0dLnnVcYYt3xSWhZZGFs4z0XM/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Am5OLymG; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Am5OLymG"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a3f1e667so14131651cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738945744; x=1739550544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuwKjNIyamlXv9GNIw1RStP37nLjo1Z0L3Uzn683JD8=;
        b=Am5OLymGP1mWNAu4sDdyRW/Ud3Iw4M9+k0HcoiZaPIpcpu31LYMFFeXkvEFunorelI
         FBD6OVUAqG5mpss7VB030Z1mbdZE1vsixdZoiLZ2mXcD6MYX5HdzR1OSKKU6UQM1NNkU
         hQkZV6B8BIsCuQ0TNnytcSE4lNPIkMz0AmwjnB5r44OhKuR3K8Cc3zGfZ1wm3cwktaYr
         Q/iGpQGDN8O9W4xv3ExQnqJDVAZH9G0vT1U7xHG7nuOFCDoMs+gY96BoEOj/f2ejppon
         Pgu4I5dP/3/CQ+HqdWBJJUcVsGxNWuRShUPj3dfWK1kzmq7FC9VRZbXNWzFUh/rbo5cF
         Sivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738945744; x=1739550544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuwKjNIyamlXv9GNIw1RStP37nLjo1Z0L3Uzn683JD8=;
        b=Ax93+yQv9KSbA+jBA0/PyB9JAElBDazq2OUe0OvZDbb8j3eiDTGNd19hJ8USdf4z+i
         EsJumm1TUCPrb+vTaqYMmbw10stJT838Ci0FYytAKpxfPUbgrkyyTrtlboHfCv9XUNSi
         taHYYzXjQN9P30ilktYtIwgbsZmytQscyIlB9Xa9S/1en+uZnCYlDqqWTws0RMBjt2zx
         b7G7iL439HajSBfEZIzXvbBrpETwmMMR+M2Kv15n8jCzn30OpRjEkGc9Nm/Y3F8sq4aS
         UoH58O6U5SxvpkxQPuuwHpGrk5hu3k2PLJz/I7yaTwu4y7KTivb9RMpw02jmcSWxkakM
         4/JA==
X-Forwarded-Encrypted: i=1; AJvYcCXmnCEszfrDOEX39E+Xy2nv8P4xKZ7EnQbRP+/D/S3H6Anvk5LxtLThbmmriSlHl3sfLoY+oHJpFa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxgn5nOZr3dYZOPMdt7RmzCV76ADR3//SzGNd/f01Pv4epIX8G
	FiODJmmi3rGyxo9VmQxGWQYg8/Ou/NYNzWD4fr4FW4BQ5L/Ldc0hbJ2tepQPdwg=
X-Gm-Gg: ASbGncs1MzJ3ut22xXIQFioT4Pfp7lv5ApuLOneKGp6ePv2c6niNeIM+HMFRXd6BNo1
	yXLjTvg7jZxEQrz4+dtLB6w+szcmKxUOIGsul9kw5VF+xarshV7yoDFuwECsOWFgm7dQUUouBCn
	p2TrRz4QoIqW0Q+6DeNM+CoJ8N0EA9LPOGxPP1g6OWcbDiAAj730jL+93IOwtdeD+Tx7oO6uLvb
	mQ/5PZFMaJeJNM4fTI297VdKlhmH8CZcQdZLyD44FbgSuqR0PkhEJsKD9Tu0q5h8tSJfQBmf7W1
	SNgXYgpDrNgx9C4lSOWFpHEouTJJ0DUsjqlYrZ/BvcHbYBf/hqWAZV8j09qsb4hmk8geb6mtSw=
	=
X-Google-Smtp-Source: AGHT+IHQAWmbysLX02YAGwkH8oMiID89cBQFNJKcH9csyPpK0VEmVQy/XH7JC/mzj/dhUwQ7C7TLgA==
X-Received: by 2002:ac8:7d86:0:b0:467:7725:8b69 with SMTP id d75a77b69052e-47167b2ebe8mr53489691cf.40.1738945743960;
        Fri, 07 Feb 2025 08:29:03 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bec57fsm18399611cf.73.2025.02.07.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:29:03 -0800 (PST)
Date: Fri, 7 Feb 2025 11:29:01 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 13/18] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <Z6Y0zecGPhlHgVMd@gourry-fedora-PF4VCD3F>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-14-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-14-rrichter@amd.com>

On Fri, Feb 07, 2025 at 04:37:48PM +0100, Robert Richter wrote:
> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
