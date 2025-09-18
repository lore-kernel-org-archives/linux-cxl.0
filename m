Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE8217733
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203983; cv=none; b=fBBOTxQgORakLnlQzteNkwOLt7Oj1WNVigub+08nh8lx/ttvGpTI7r1uo9MJqb2O9UVBCco9wxHdK6RuexGcogk8d2WlDkls9pao9iMCzPDdh+UVmMUAgIAmUj54SMnT5cdgdYueEf+QWEtFvx8T50YVHUtYd99aDVgAN7Op/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203983; c=relaxed/simple;
	bh=N7r1cHBrTftOK36ML9zP4d5ZUGLyxB2f5d/SCmZw5mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYaHDPzQr8S6MwKmF+aVGd3He36V+Mm1Pe4h6sds9ACbmIX0De9bHgIrykOgBQmZvFJXViyPwF35Wym3/ImT/sicmehBXl8g6m0i4QnEE1EnVdo58xxmyi6fhx6I4gCDkNzLw1Diiww9v40JTy6+IL9rEUQm++Xd5GM+Mn5IMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aA8FTHCb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aA8FTHCb"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-826fe3b3e2cso95845185a.1
        for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758203981; x=1758808781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qW5naJpelAa/fHCeFC/F6GWx7z3AKGF3THG0OvJ/RBQ=;
        b=aA8FTHCbDle2tc97WncHKeSCwpOCL05hcwK/qSyovwPliWJCj61Zgp2YtUKC0Dd6wg
         vum+/jkZ0Jqz1lYIaqk5s9otCt5dEJtJVuBb1HSNS9YCLd4hgUkqowcdNjwUjrbuDPYA
         e3OldE1cGkMovkBXwhEgn+NCIF6yI6/BXNNXc4p2kkCggUQz4LbrAlv1UXbnl2T1Cg7u
         QCm8Ec49IZj6NvSKTtzyDj7KpeQmcy+6E2tXWHzVDZnUKhIqqszQds7bNKP8aWlZ6dMV
         3arhfFCKiHxdVO4fXcSffdvSv3pbKFZHePRRPV82WP8k7ZEgqmqyIRl0tc8vCU0P13C7
         SN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203981; x=1758808781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW5naJpelAa/fHCeFC/F6GWx7z3AKGF3THG0OvJ/RBQ=;
        b=mR5mhq2Knx6xobI4o82vdDcqKbzDDayzQXQeiF5Cd/QoGL4EsKEOOxV8jlGQ08zO+O
         1+uUZ6OCIMJmzg5Z15oMhZdW+XVM6jWgRu6MEjqnyul+XTrNv2+X5EcWGy05DHYWmiU6
         dVdp9wzfWiKLHJN1qs75pTIe8cJOaGTxTW003PH3K4LWwJKNtKMUKTZ5K21256E2l03y
         xGHwD40IPfhJEIJJGkJCSIN/kFuiRSXl4B143CXJu+M4kFjbXesx7RVuEo1gnUZPUuTn
         eG7JZe8dyWm5hDr2qE4RnqYFo/OX7Ik9ddPFLM0WwDWMkwDjc9amuMDGbV4tcphi08D/
         zMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXttp3iP4OMcmS4D80sEu8EW6im7Jq+hfPRHEqxJGcoWByVAtcrDupQlsR47QsUebwXDGZOYTpmSaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETdRVTRHjD9js6ozBHo4yzICjhsQK5JFVmQegnTqu1hs8+k9t
	B2M9R4Kayj1QNqFndDHsT1CULjFXT81nD6lSRUVrQegBWGbv2QCp+eeBokjmjB1/PEw=
X-Gm-Gg: ASbGncv+Qy5MLIuou+E9nu7kMEf+Q5UBtCSLjNUZJx3XbEmbXXifno1b+9yw31ZcG70
	JEPieID1Tc3E60s3/8uTEUK+QyspQb6zebRLrpJtqJBoeZhbXdyHv1v6CS2/GH70jlFoSde8awP
	3h4Dynr3HMOlM3RdqnyjGkarEieG4sv8cTj21Dv9yNYtxGkRD0t979/mgJmty0b2gvGfiaejyMk
	W8bAW/3XaFF12Xre3Ve7N77S5h9AySMplZ2muDtHAnTm3qoPfB3kx7JLW6O0cF3VYPEzfKBp4sL
	5SSDdb+nC/vNxO3E9Jy4Ibouczl6P9HUJHGC3e0FqR18Lnf61MUNlSu3J4k0yJgRxBXMNTS5W4g
	twxP6Wbhfu1HV06oTiwhybOuGxqh9VE8wg04XA+U8be4wbuwwivBiQgj4
X-Google-Smtp-Source: AGHT+IEwqImpRBrim40+l6qWMgI9cnm3yGnyzb/zaQbv9aJ8e0v5cQdRF87vMbOiP7dnVMILNYmQwg==
X-Received: by 2002:a05:620a:471f:b0:7e8:2322:24b5 with SMTP id af79cd13be357-8310765993emr614510785a.3.1758203980771;
        Thu, 18 Sep 2025 06:59:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb91:141a:4eff:d16b:dca7:ed2c:70ff])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363203a51bsm166257385a.48.2025.09.18.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:59:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:59:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
Message-ID: <aMwQSYUXHtZidrpY@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-9-rrichter@amd.com>
 <20250915114614.000053f1@huawei.com>
 <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>

On Wed, Sep 17, 2025 at 04:51:37PM -0400, Gregory Price wrote:
> You have to do the alignment because the translation function (may)
> only work on granularity alignment.
> 
> Example:
> endpoint1->to_hpa(0)         => 0x0
> endpoint1->to_hpa(0xfffffff) => 0xffffe00
                                  0x3ffffe00
> endpoint2->to_hpa(0)         => 0x100
> endpoint2->to_hpa(0xfffffff) => 0xfffff00
                                  0x3fffff00

minor corrections above if intending to use for documentation
