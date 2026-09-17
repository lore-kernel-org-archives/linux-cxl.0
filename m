Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE3358378
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614345; cv=none; b=dIB0gNnceMuA+4vORgY72XN+SRGOCdUWaT8RHW0gpwFblKa9s4H6Ar2ki4b0F4JpzP2ARDlYfvrtccEBWYyQFc4H59h6RpiDph8EGKnp84FDDyyH4JXPZp71lKS+dyzqPB9mw8azggCaMUL0cWc8x7h9vi+hodCggRci74mG8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614345; c=relaxed/simple;
	bh=6uQ5OWW7H4ulEdA2z8ij5WrmbUH5gDZWQ2ifpBaR3DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNzOpiisb/JUbfQXPRNVA1XwRVX5jSILMB7bevwrVIuYZxsxOPEaYVEpfB2K1XFR7Uh3yZzvYOXolv2QynPsdViFE+uzULGQbHFSy50xPWnBYuCWWpXJkRQ/hH8AQzwJ00Bg3zqFdLHi2rQm02dUOyhblOgDqmlFxAgRIG9m3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZWb2jbMs; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZWb2jbMs"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb767cc7fso2709691cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789614342; x=1790219142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n0GRiQfialiJMiI1zO6awSFG6STyMQz4e6XIbjgnf8o=;
        b=ZWb2jbMs73Txt90QJ9CKz1F2hG7MQW3Q6ElcVLR6Y6l97gNFAnDTDup7iZ0XrjxIDL
         DrC9yt4VXQjXi29Lbb0rZwNpEpHCHqbvUy+AL6cDzUTRqNprDo6+uqm0pSzPdoo/Df21
         6Cs1PL4yBX3rSZkEidx8PJ4XW/DcRTUiWvg35ocsNi9Gug/R+smj/wiiMODcKWZ7zF1V
         fst1OVfhh1l2e+NjVWz8zm0doGRvSZZGmDGv0v6gWnE8LEHxlhC8iPfJfcQCaxRlO5kP
         RmWfIj1+FUrxatXJzXsxiLkCca8TmGllvYcJVhH85Htnuw9l1VNT1ZwxSoFbLAPhGKfq
         zQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789614342; x=1790219142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n0GRiQfialiJMiI1zO6awSFG6STyMQz4e6XIbjgnf8o=;
        b=N6G5QSgdvDR0Vr6UaMkSIu5pYp+88MVbHxWHCuUrDkifZYP7maAcsgMsz6v2eER7Vj
         K/0zYY25QCVJf19/cYUvg+EnI8lLKNdvq6g2XFLljoQMox44ZrqproQ3LJsfCJCqTlzc
         k6WfWGbL6CMykuthSq6B3GuzlB2b64eGFRZxZCHV6W/xuqRzPvxe84a1hAEOn9UFFtlt
         PA/r8im+LxunY9qhIxIPOnDwXWbS0K8Xg5LCNKU8TDgYzAUqVHZHJDiiPeQpuf7GqqLM
         mrBA76X4O8E9qdrB8A5eUEjbPr2H1IW/A85KjZka34KQEYd1zajuL4uwgH25OC9xoVv0
         /pdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGrI/iHk3N9Ny2L1ccf52E9ia61Q9c3pswMB/fyV0BWjAlL8kHQdxS9C0uCuYlK/x/zRvlB0HiSWI=@vger.kernel.org
X-Gm-Message-State: AFuF++mQhbRDp843uDaSlV22vKoMNZ/94IBp+RvobT4OqoZlveqLhgZ5
	OlUNDLUdtu03M+ZS8BPA8qusJ6M6KwfZSRTfpcIXBBvfEgBV8TeqQ8BKaSC2j/t+Ukk=
X-Gm-Gg: AYBFou3yEzCTkT0FeounzsWsRgnAIvqT5Ji6+toGtfZYNkzFeJCIQSlqlL4VbHuXMN9
	WkiJUPsb5mfBasIF5Y7y4zDnFrC1RTj2xx14kEvbgk+wSbuEDZjrO5c3d40m8EBKvWC2cIJS78q
	0zUWJHO1O5ZraFQQY3vnohFSG8SlmUxKa2yPZXNh4DBZ7KuZDwG5DGrvl6Udiya62OX1cjcwKEq
	i7n7gdrpHkVTQHmcqzYSc3udkNAOrOR0YwpiQSIYirS/UHd5jRdWZnisWkOoY4QVIqbxuE/c+gA
	3alxIaf2UVjSfS7yE12skovJHzuykALntev3JEBbmO6YzYZRgBF47y9KzW+aEK4vAc9VWewNaZu
	m33TX9MSb6YggtEPLQBf0vet/eWdpEqkQCrCWkDiN+CSHFdMGUUDq4z72zJ14uDbnb78xCEhEPD
	vaEP42xMcjBdPMPl8/NZAiMGUmH/5z47mKq+d1xARoS+0bABJ0ctWc6jUAucymTFcLsOzCvm9aJ
	YouWSsQAxREu+6CTAnGZnCFK2pP9O3vXDNcfp//Q/X0iyErcJyI1HI=
X-Received: by 2002:a05:622a:107:b0:530:212e:6dcb with SMTP id d75a77b69052e-5327ebef29fmr84689961cf.0.1789614341818;
        Wed, 16 Sep 2026 20:05:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53259aed4b0sm38685521cf.2.2026.09.16.20.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 20:05:41 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:05:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
Message-ID: <aqtY1RRm1ITv6tR6@gourry-fedora-PF4VCD3F>
References: <20260917024632.1397380-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917024632.1397380-1-kanie@linux.alibaba.com>

On Thu, Sep 17, 2026 at 10:46:32AM +0800, Guixin Liu wrote:
> A NUMA node that only backs a CXL fixed memory window and is not
> enumerated by SRAT has no memory_target in the HMAT code, so
> hmat_callback() exits early at find_mem_target() and never creates
> the node's accessN attributes:
> /sys/devices/system/node/nodeX/accessN/initiators/* stays missing.
> 
> Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
> by SRAT") had the CXL region notifier call node_set_perf_attrs()
> directly for such nodes, but commit 2e454fb8056d ("cxl, acpi/hmat:
> Update CXL access coordinates directly instead of through HMAT")
> replaced it with node_update_perf_attrs(), which only updates
> attributes that already exist and thus does nothing for these nodes.
> 
> Create the attributes with node_set_perf_attrs() when the node is not
> backed by a real SRAT pxm.
> 
> Tested on a QEMU CXL topology with a CFMWS window not described by
> SRAT or HMAT: node1/access0/initiators/{read,write}_{bandwidth,latency}
> appear with the calculated coordinates once the region's first memory
> block comes online.
> 
> Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

