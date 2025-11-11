Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B93043BF
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869710; cv=none; b=Ow6gwASrkGczJ+fAfzvOckgGUr5ZvSwYAFMSLMLMByVlJr6J4iYLzzGBREDgHFFtmhYdOG/FneV27Rxj3D4gfnjeZdtE37PXlBR8JpEmDq4U3yGWT8WxbtnZkMpNB4nDPUf7U+a6SJV8BW5c0DR0vmLhBRPp6Dj8HIybqtrJVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869710; c=relaxed/simple;
	bh=KMzpcEkWVzPwJOALZcd5Z38NN7WAXyzUhqVifBdo8RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKcXJq0VsVqHs/Zv0Ttp+/eTi/LMjZ7YAG6o7XLF2ATqvYnINvG0/Fajar9R2ZUkg9fUgDftMa8xPl6w+dz89FwstuZR73qjyF6xkLyQg070ZwE8W7u6U8YrJe6BtDZDJsRyCpYnSoEj+QTeKnBGGzbn6gVFQbXtRjtKQ8pTI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LgO0m2jH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LgO0m2jH"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8826b83e405so3588586d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 06:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762869705; x=1763474505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVIlbaArLD+xEsJRTgweLsSstkPgQPx6U1v6mUAh+wQ=;
        b=LgO0m2jH5gRmBfTq3ouXolP/anXHVuWs5qK0vAC5ByrETiRazeFQx0BB0v8+9Sse4w
         aHlc6NgrMc6sHiQnUyaXXmwcDER0vXvKB1nqzEYKRGs94Wa2kfBF3d1CWQkNeS84vZOV
         3WxcPHeMNIpky5rJUJT09Z/cmFt+eXf7nQXfgy0LWpEBY7AGa//V4nyBjWS1DP56eB9W
         4CxGm4UKpAacET54Ik8oRIe0d0Pl0JKjQoBhj9/1s4B988AIYQr7y5IOUkk8+Dcv+SYJ
         cF2x+/KVE9j0718s6xZ/rIg5Ku6VNnPlIt+WL9ZQsWGmcxz7907TaDStYi69ZWd2uZI+
         MQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869705; x=1763474505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVIlbaArLD+xEsJRTgweLsSstkPgQPx6U1v6mUAh+wQ=;
        b=MSBfw0WExwlPjLiHwxn2pd0NkHye+9yx59Ug7+M1ZTi+6tnx7E0Q8HD1/5fCPGRFjt
         7WsBn5agFlJiOqEQhEGHyJxWPcdjtQ29pw4z1R9XJ0egOIrhcIqoanoy9LHcgDl6Ijvi
         B+RWJW/KQI81jBbn66ItvR6Ly1E9Rvez+SZEbazXJLC7LYdwrjicvJuAv7OUdM4Jot10
         pUs8D99Pq0J73w9hf9Gsj2u7/pU42/ZynLwUmSiwF9JZ7POrE8GUY8soAnM/r8yoMjmk
         Y5AMRjSVZFlBkD+HCxGP6mNCozv1bUHQn4Z+658hueJTonIS6kVC3EdNGDXyNairxEtW
         iu0w==
X-Forwarded-Encrypted: i=1; AJvYcCVDww1+uriaPEO/Fu+Ne4l/KbNSXlNO2q3rBwPEUGn6Asz8WECsm+yQknK3ywLk71GW0HfsJUdftS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgOWIgRomTdhCa+Y7uGnY2LSpNf0HQP2aGyg9x6CqUt6GQg1a
	SsoVE2KWN4sne4mrCb/Gi26ttGtHrXVyXWkxywcLjrEwjq9pE81DENNZToJ8li70K+4=
X-Gm-Gg: ASbGncvidVN775Z9Mt8j3ZHIQMPmVHaSZz7thjY5VFhbIHXWNg628Er8wMpLgNYpwK4
	yOsHZYs8Y1SuF9rUFf0Wk9g5WrYFgP7vXpmJylXogNVEE4BP+FerCzp1H4LKXgb/kF6bzRDcgwC
	SeEcuLj+6OHpAKdXwrhjaWu14u1Fat2mezhtRZSxVANONqzEucqfFjdjpC1PYkDkSaGSvvmWCDz
	f1178pjpQm/XSX4twVJRJp7PB/CLI6wyf3UIBb8Y1k9ifSjSCc+TgJ61cALdLlMwGsQTW3LaxNb
	KmmfHZ9N+rZ2DExfgV3iE6UQ1qBft7rZU38R8+wtK4htsVMmWVLGzxHVrn0WA8Dvs6BCDZgtQQ8
	Wm8a2yc3PD4B8DJVyqxlGp2eOCNSgqyitrWgCDAgsgKvUcx8F7LFI0Y6SX6o2t45Eci/qLEp1So
	MbB3p2Ku4mjl289PAjZCZPTZVKMRgLNHiwVPddZZhJkVQgZFNU+6FtM2aosalit3u/1OWTHw==
X-Google-Smtp-Source: AGHT+IFWbPEXPWLzIkOWVIuQ03hw2eJ8p8ZC0z6FbQbFz3rRhv7LpdqZn+aAf49WvkXXdHfZGzUa0Q==
X-Received: by 2002:a05:6214:cc4:b0:880:480c:6051 with SMTP id 6a1803df08f44-882385eeba3mr152689066d6.5.1762869704944;
        Tue, 11 Nov 2025 06:01:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88263830feesm11249586d6.36.2025.11.11.06.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:01:43 -0800 (PST)
Date: Tue, 11 Nov 2025 09:01:42 -0500
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
Subject: Re: [PATCH v4 00/14] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aRNBxlZhxWlaNL2P@gourry-fedora-PF4VCD3F>
References: <20251103184804.509762-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>

On Mon, Nov 03, 2025 at 07:47:41PM +0100, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. This is another new appoach in
> response to earlier attempts to implement CXL address translation:
> 
>  * v1: [1] and the comments on it, esp. Dan's [2],
>  * v2: [3] and comments on [4], esp. Dave's [5]
>  * v3: [6] and comments on it, esp. Dave's [7]
> 

Have been testing this on my Zen5 systems backported to v6.16 with
Terry's updated PCIe set as well and everything looks stable.

Tested-by: Gregory Price <gourry@gourry.net>
