Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707815ECD7
	for <linux-cxl@vger.kernel.org>; Mon, 28 Apr 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745879239; cv=none; b=Mfe0kQF+miVSlGK/x7OFSmIJN96t4mmJibGhkJYAMqCgdEUSaCeIDDG7QOYemqgUQfKX2rb+ZTmexasG9lV0bkdLGaI1oPWQn2jm83tWk/zU2bQ5X+VqNmzcv+np2ZPLjywFi4VM1VXsi/RkAc5xp5ZLEoju/aPad5UvcwFLZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745879239; c=relaxed/simple;
	bh=7fnMKjBox+OEBVjxHcU5z6wFRkR5xtmGko53KNWRG7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM3UWMOqynKsdAdOzbdWrjlfG3IwOIPYSvm6ScZf9XjBI94Dwy0TDMHvZdF29Sed0QIDJyu0qIaXd5OHnej+OOo55SAiaoLZgfjoZ5qwHBdkiiISZx+cBg0kSrxZPRlgRpht/Zquc6ZQB7BXdJyZ5i3lgnwJVkxPdDvmNsBc8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KBcOCYm/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KBcOCYm/"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecf0e07947so57057176d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 28 Apr 2025 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745879236; x=1746484036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fuP7VLRjygpUBUrW1Nki1gvJTEsUdPya9I3sGV21Rg=;
        b=KBcOCYm//3TNaWxM4bMwM9e+uOn9GiICvdmseeggJLJ2HXFuFtufikagoqOOZ2/yJq
         cfZH0goP7dvDo8YPLTktsSwskGXG62jAJkg0LL+clXR45xrN+k3O91XnjebyEHybxK6a
         GKWs/vdRu8zl/GOTsuvduuLPEwm9SRBHA/Xlfng1rpMg9fPzUTXAXxrL3M3Eezkagyrb
         IdfxKibT8Z7IepdHkKDo3zY4XoqNio+SW3hILdgTMgX/+htCTlqUi3BUMQoTtPPB/9xZ
         kQeXN2N8fHQhA/nr6RFu7u88t9Ke7UyihNc7o/JIdHKSxTpu4A3L3Eg4IbDlez9WyB5u
         Cw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745879236; x=1746484036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fuP7VLRjygpUBUrW1Nki1gvJTEsUdPya9I3sGV21Rg=;
        b=RdSax7vedJUorQcndVjFTziS4ISxCmOGcrMWGY0m5VWX9ufeZd+UA/8Kni9BmPSPbc
         /xqxndnRzP/ZOcs7rXrPktN08eWt+h+RWUNMWY4lhY5N3Knh5LbopbcwMo2NebEy4nKS
         oip5PX2i+ozg1mNq9a3LayJDRs/DJW26iuK6FMul704BjKI6JKicAJrKX92Ws+IUiXKH
         euhhdYWLky7thsQeTqxqOz/6aPjj6/0ulMpldENt2m9rm1/M4ND1gcNFwo63zyYiqtuk
         Vqr8pEycgyXk7xQL07igDtvJRSKpDMpcS4EEZdQAVBGFfq04W+APL7IyEx7fECYZmn7O
         lQhA==
X-Forwarded-Encrypted: i=1; AJvYcCW9wPhClEgzn9za6DvNW4YaLfPcGX2Ec+pALLk1U9HoxzpSECnD13d+eDc1rPIQhhmj7CHXERedA44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8CtGl1atTOQeX9o/VcSMQ3tpwQMPNTPnCOewTRfs+WQhbsGh
	JPdl1cIntsjZZ6R807yE+i6M4cQFf407n3xn3WUSngH2h3W2rufC2SNXN3Da/Lg=
X-Gm-Gg: ASbGncuz6XEdBXL88QcMFQeyTHCr5ns4+oiId9eZiF1iJ4vZCl3iuQjHPNPs2mdXvZ5
	dLNZXBCa8dkRIujOqscGzOa8UkCHyJIOO4b6npOTmMJTbScyw+1FjhDMMvbN/785kcdPIZBzlJb
	GJpJg6UYBIIFTDHipiS61xOiFrfCkeUEjhaWQhM2hGYUu2oYF/zJLoVp+wP+j/ogFE09XWVqvvF
	nHrhT1UN8O9BkRIy07JjcNL8cOAA9ugtS93ydFk/sFHxIbqHsFqPx6jsPEOU5FGzK0KHOvH1GL6
	BDdTa5iHO/LURfuZ+SUg8U5gE7G1favy6mxQy2pYtJpU+wpXYE5W5hiwThnMi2834jF1fZN2D8O
	kgWZTALPFl9/dEIcKsw1StwU=
X-Google-Smtp-Source: AGHT+IFzppIoEenYmm9CPu0E6btppZX+5Vg+VhrXb8lAiNGRQH1YSHf89Ar9XNk4Jy4VQsxooriCpg==
X-Received: by 2002:ad4:5967:0:b0:6eb:1c23:63c3 with SMTP id 6a1803df08f44-6f4f1aa66a5mr17281846d6.0.1745879236406;
        Mon, 28 Apr 2025 15:27:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aaf904sm65706686d6.101.2025.04.28.15.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:27:16 -0700 (PDT)
Date: Mon, 28 Apr 2025 18:27:14 -0400
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
Subject: Re: [PATCH v5 08/14] cxl/port: Replace put_cxl_root() by a cleanup
 helper
Message-ID: <aBAAwnQ8x8235rDj@gourry-fedora-PF4VCD3F>
References: <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-9-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428214318.1682212-9-rrichter@amd.com>

On Mon, Apr 28, 2025 at 11:43:11PM +0200, Robert Richter wrote:
> Function put_cxl_root() is only used by its cleanup helper. Remove the
> function entirely and only use the helper.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

