Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594474690
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140153; cv=none; b=N8XEJRZJokUYzqrmbULAKhWHOUn8zVFB0oVRvBhZz6d7VpTDUZAHGJLd3jROCLvlUJ4qdfOIRraTJvws8Ffi0NDuXJntLgDQSoYIeHDLeHP2V6D4S3QkXReZjxz/8ME/JFTofDYrCqfucVxALMDdI92WqC9F5UG+gqIGgzTu+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140153; c=relaxed/simple;
	bh=hprFr2mbLO7Dc0q03PRetfWltdRAyCxGcGAVS1oAjYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ansogb7Z04kqVQJ65z5bvLQyp90gNz/WTe9WtmB0ig0516V3l3i96QZph3EH53i4uw3nnvdGuoRi+CZpAkxQCy+0cojR53TCK+0mlzyrWCuoCV/1ma9gqMzjnqnbsif4iwBQNzNYj2GoqI5KEgnwxh2jgHsfPbUROQ/5gZIi2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j/+Cbr6+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j/+Cbr6+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-826fe3b3e2bso28040185a.0
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758140150; x=1758744950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zzmNSoTqcfTDvTbjrGv3mjnhhSw5aXyU+noP0bCST0=;
        b=j/+Cbr6+F+WwwyetnLnPgC6eUH8Bf2BiQBDdviAw/h7H1P+yhNqk2sAx7H99aRKcB7
         PuyZmMF1b4nGgCLLgb7kMpqzQrQQ6/HZoqQNLBMGB8QNZacdlvgxr+enYmNeRoIqiU7m
         vJYmjOHlW/vTXTA4Ts3LIv/wggJPMlsim8gAbvUljofz+z9Q1plCT7wwkHc6dKCvGYlm
         vYMcUYmHRkAzJa2yEapG6huZRqndHuzyNMVaF/yWhFxcfhBaj+Rlc7+BMOcA2cAmNAEL
         FlgKcZGLQTZbwfyU+2SwPJA3NYDm+HviaUjd50NoDlPtGIDrCvTt/kiY2Bao3UeAFpkv
         uCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140150; x=1758744950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zzmNSoTqcfTDvTbjrGv3mjnhhSw5aXyU+noP0bCST0=;
        b=B4+u+SfjpSCyKNSihUa42RDhY9edBWOP3H5QU9yWJkXEcs23aFAzyXDQRILy8CioZb
         1WoDG8LQU4TDkA2lz9f3Qb8IwGmD6V/iWhjOk03Y2GIS55dFHzjM3TZXaBG/N5ICfkUR
         6YUgYO4sdCBzbucr0jxfxu5z3XI6VcAFiiw6DpqKcmZJ4wLO37gHoaDD0vdNWUeYqwTR
         hVzDh/1o8BHWUdUdORPW2Rau9GKA+RqihD+isLfK2CEei66p8xupiW62tYR+2cJSpYmL
         jnoRAEK2mIxWF/C2m39h4VRPFTl8LoNXY217IDmug7N251a6CsLWpxSEMD9WOS6SNj2K
         scVw==
X-Forwarded-Encrypted: i=1; AJvYcCWKP7tTHY+KX2hXuzVZWAAN2IKlMwR9I6zcEXMExbYvAL/PCXttM8Dx1nJOek9brFpg4Y53V+LyQEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZg/xUhvZYqNYvNQJVCC+6/8affOzXF5CtYBtKf3IozFGKTU27
	a1HI51AE/Jmy5/X/0gwu22d9LUiLN1uNyjHBqqeSsSj/l2RnE5Splvx2Yel6O9gzQeQ=
X-Gm-Gg: ASbGnctBs7SoqIMeFeFy9714e6AfJgx7xOo6rGt9B+uYzojIr2D7P/4aVAXb6rKmNAa
	xwV+VHSWOxHrZ1C7VZlDU/iG+Rt+mdGhb5K3dr0Mr+oUdALoF+3r8Tw2DFSC6nPH24lPpg+sb+8
	rD9ga0OUaS/utWM/IzZBTwxoP/M/oEvOrmSQkuu8GkLU7rGB6LLjNbRLcGGFS9DHDQPHsp6Syqz
	BbzdjWuJwyPxSHXWnTq43rbihwVCvKuhEb0yQ0uaGTkx38QNK3/QQiQ1ZuYPbxfWRuvECGcx4SB
	+5FZpovinuxruFjMRTL7wFwx1E+qLFLMtr4OxCf9v6i89jwher3G7Bm/6LrvvhxC7Euk4jkjMyg
	TKYHfGAocPnBsO9tkJa67S//l05dYICPCE3PWC5r1Gv231oY7AV/8J/uAHjtpCFIW1/ERACQiJg
	nY6jY=
X-Google-Smtp-Source: AGHT+IGXaRXPa4Q2NeOEB02JkjcIfRmg5OQYo/B7/nb8hY7l/sz87uniUZfDKEK93NY7857hacDNwA==
X-Received: by 2002:a05:620a:40d4:b0:828:6f7e:879 with SMTP id af79cd13be357-8311390bd2dmr338279685a.52.1758140150142;
        Wed, 17 Sep 2025 13:15:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83631a8095esm38373485a.49.2025.09.17.13.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:15:49 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:15:48 -0400
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 06/11] cxl/region: Separate region parameter setup and
 region construction
Message-ID: <aMsW9BW85jBxyCIC@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-7-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-7-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:08PM +0200, Robert Richter wrote:
> To construct a region, the region parameters such as address range and
> interleaving config need to be determined. This is done while
> constructing the region by inspecting the endpoint decoder
> configuration. The endpoint decoder is passed as a function argument.
> 
> With address translation the endpoint decoder data is no longer
> sufficient to extract the region parameters as some of the information
> is obtained using other methods such as using firmware calls.
> 
> In a first step, separate code to determine and setup the region
> parameters from the region construction. Temporarily store all the
> data to create the region in the new struct cxl_region_context. Add a
> new function setup_region_parameters() to fill that struct and later
> use it to construct the region. This simplifies the extension of the
> function to support other methods needed, esp. to support address
> translation.
> 
> Patch is a prerequisite to implement address translation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Dave already got the init code, so with that change feel free to add

Reviewed-by: Gregory Price <gourry@gourry.net>
