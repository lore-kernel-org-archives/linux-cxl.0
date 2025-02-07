Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD72235BFC
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915730; cv=none; b=T195moNCKc91Bgn6Krw/jS051TgkJ2ZzbqDOXoMoQYycV3LHYwAbDDAZYavQ6sI/9eOBmHlmiqhKoCtV9ZQUIf06gy8DRK5p8rvmCyMt5H6GhXgFSule+vWtCuLjvPsx1CfB8iCghqrHVaiKZQ7XQCaqX67QDIe/4gL0Lb062y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915730; c=relaxed/simple;
	bh=h3JF4kg25Ak8+7nLLyUwiuxQxmkQn+2HaY0HuhcaeGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwTYaiyHHMN5JEKnGpyPWxpKZulB32dG1/4sEYiGXFOoRQ0cEfZycCTWeIGMbHfI03bmPzu2H3SLN2cFQl+ou1IsFLJzBz5s6mXQLUh20aUkuteScjlmKcFQ6Qx4UHXQ0RjT/dDzFv16hEkdmZCTXvfiBetpJi0Ft/+GUC4rHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GTHNJpve; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GTHNJpve"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e9586b82so159749485a.1
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738915727; x=1739520527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUqfa/7a3uRLS8Wt1E1OLUz0+AKRuiORplPEOlwtwdU=;
        b=GTHNJpvev4shxMIW0h+r+Ukpx+zVOG3Hxjc9gPtcsLQl3yETnJgjJwUvkCHNUut5p8
         8LhAB1fO6CExbw+vbrFzEfycyeRaImUtXufNvEKvBuZ6UjDt0cKCxXcUgq4VrFQyZBSI
         8qqUEVw3Tn3v8lW/mQD+eSOq4B2a5WaUFJkZNUX1ocdp48fpeTFZTAzxKOVs/ZrdaDar
         jroyiq0BHqOa4wn4KvgT4RoZrL+bDnypnFxxUS/X7eopJmHbcbcS6qRq7Qj850qxVAY/
         PHmRQUhfB/ZF9cOvu9Ct3XEaijXwxu3i86XGg6qBRE0pE3GI6RcqeCscdttaLcKF5mOj
         UWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915727; x=1739520527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUqfa/7a3uRLS8Wt1E1OLUz0+AKRuiORplPEOlwtwdU=;
        b=WQt+9Lb3+d/fTwG2pJK5jrJz3I/9GAcEQ/yaGgEZCtbXGbPkyuBQvlGGPxGHyAPdkV
         IDnIIRjRp6dIUwqsQmmbDgIJ8kJgOOTOj0Oz0kN4fOnZ3lMvtbgT3pWD8eWy7f6zLVaJ
         KeADcDt6aCZmrq2q2p0+DhsIk1N19A5FZwvBrGZsWK6Y9x23dj06HM2HxwaoVWtlti7u
         sHbgYozFDduDs7huZ6DdS9ut/p42n+AhBopt9oxtKCiXyjVAkw6yVUg3AMhk+WB9gjiY
         7gC4MMe/5TSQAZ7OXbQwXN+bpcjd4VVivWnTJQPbQiZae2qxo+JmvMhcOs3s9muBSS+n
         Srfg==
X-Gm-Message-State: AOJu0Yz/+1JnatOFEYgYzpyPXoh6dNNNdUeyJti93yk3wRgZLDI3nYxK
	P4gSF+M5niJGEUrFpJoaNCM4qyymgOsdCT5sS+HXjIn1FCbWQpBzcrs+Zsd+7qU=
X-Gm-Gg: ASbGnctH/fVCOLPV2PorgWDhSqmLz0ut3H62OtmMAegX8UEeK4N4fm/bccx865MwkzR
	BR637CsC5Ux0WGcffl4cctMRCQvN0Lu9hl7CEztvKhiBWNNyCqL8jPD79LevEw2O7M6cZzBmYwi
	9As1QxTmESVj/Napjy/rkUGaySGbnE+VkfyCmQZFhBLFWTKowhF4ne44hCkKUb4o2LDOPLQtlHh
	hhfcCJCHJXmOH/aEFu6rj8sOZvDpUrzQfR9euX8ayBwOTG03yUCACrC4/b8iQkIduSRnuTT4BEp
	VnbRO9bzZKo/BZTe1yTHXqVg2RO8AQfyQk2v9BeoCDm2wwzM6asaw7+ZqO4zWjgTNKb7h/3l2A=
	=
X-Google-Smtp-Source: AGHT+IGSIwnmOaKReWyusyTMXh+GJeL3zpoikJuNLhCbaUo+fvusPWKlRI8qdyFQIn++zwWdc6+B/Q==
X-Received: by 2002:a05:6214:1d26:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6e4455c554amr26905936d6.4.1738915726917;
        Fri, 07 Feb 2025 00:08:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacee1sm14268386d6.84.2025.02.07.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:08:46 -0800 (PST)
Date: Fri, 7 Feb 2025 03:08:44 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 15/16] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
Message-ID: <Z6W_jKNZfrRBIirQ@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-16-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-16-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:51AM -0600, Terry Bowman wrote:
> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> The handlers can't be set in the pci_driver static definition because the
> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> driver aware.
> 
> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> function will assign the default handlers for a CXL PCIe Port device.
> 
> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> longer be used.
> 
> Create cxl_clear_port_error_handlers() and register it to be called
> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

