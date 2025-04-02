Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247E1519A7
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633170; cv=none; b=mwU/gDOXCOArGX4997U/5v1RR3pYHkwxuk4eD7fzdlqyBUjdaFoeWIclCJvBDafEajkKyLxbcnodKyS6CN1CGLI+ju0We7A0VQadfW5E0BVKKe3DQasMnZ/seUDjbBl9NAMUHsx0fuAG1j5iSW8fm1wASdKz9DsXKmtq2es43K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633170; c=relaxed/simple;
	bh=2ODM/RlzT2gyetcU0TsieGnzB8CpYRIKICJRUjB2mRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW7Bq3KziyYmSQhO8eKMrhxP93fXExr3TSoiyvozgzhsNXQKENFf/JbpARZQlltdXqjbGf97woWSr8jZINGLlIxb2qy7cql2rsxcFAUQ7L7u6W0Ewraz4nyHrv70CzHQY1wGUwvN4fVqxHRsasJjjyNcUGyEAZuFEYQpB9Z5KYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jssT5Ib/; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jssT5Ib/"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c07cd527e4so19934685a.3
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743633167; x=1744237967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQIqy2Gk8MSJ4ovtO04TmjPR/yZ/xnoviDmFhMCTx7w=;
        b=jssT5Ib/RAe0do/0S8DBE7mW93zp5P2OFP/a1aPRIYF0iZntYEySsIOAiiGfuH1Sna
         zzZc3wA+Typxaix3AcfnlHNqWCqUE7AAW+VhMUcFamb3DRo131tifxn5N4MpZ7PihdzQ
         jF0v5BOrg6yhBb8nceo/FFRVT71Y+kNw0b8fugEfZzCjEzMnERJe1b+Hed2TWxIi9YAs
         msS3DxTEFkOehChnlCg29FndGRrz976FDNhSdmrdeClFMSaxiBDxbpvmpxZBEaXbcCpJ
         Tnd1bnWAmatBQQykPpxN93guDticiU9wLslQ0AkybDbDa23jg5E3JuTXFSEXT5RjYb+l
         3tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743633167; x=1744237967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQIqy2Gk8MSJ4ovtO04TmjPR/yZ/xnoviDmFhMCTx7w=;
        b=LJmjkH/bYgSxFJ4GhyzKLAq2b4WPYRVVnFbfSYdDsWtP44UcxC+wV1XTc5QgX4OPdl
         gG4BV1QfVRAW83mFx+q6XwyuGHutgb+Nri+zRb3uljNp3G/EHo0Eiaz8gasZ0hcCrp5D
         eCXh2ACjWL2lMaziDpwtPQyRMFgeRNTuOrSiqfHDC591XTUzkgEtFF0VB2W6BEAOWd6c
         r1y4cD+ZPL4/cC9Ol2syj+WEWUb00DaGpoKHnYMuy5SFaqSpG75CH309CNMzRQ69u0Fw
         zqQSK1sgl60cKHdqvLo/f/7PHBkHOtX8bMrRIlFluKDhU+lhbTQtPU977kYo1zg+vmwM
         KBZQ==
X-Gm-Message-State: AOJu0YzntuodSQL12y34CeGUyXTYQk2X7uYnqU+bKIr+FdCa62vf1xg4
	WbQrHxbCIBwJbCiWSxwkdijQeOME8XoFuiqzpNrphJlHZdVRGo7LmrUPMXveWN0=
X-Gm-Gg: ASbGncuaoz6qP8YCBCIyUCKD6zbV7bgb0u48LKyQeJP3AgEUZ4xJo3FNTgnzp9qhW8N
	NK83iBuIV+jANWZh4+/GnjBKoWyKaHiM5Tdcxmqw36fKAuGZcP8ihpFv7BEvQvnOljDS05uJq0u
	foKkRoY4obLKEplhYOzqFhF79TLAm6Z/N/2D8+HUrEXMFbr/W8OOoEPjPKjuVQEU0dEXosBu88G
	NQ5a2WsHoKY1mNPjkORkb7d8UNZWRsywWq5Zf0OV0hCVJX+y/kXugKkBaPP4GQpBKD1ITJOI8pw
	VnlWCpnfP7G55Mnt6lDHAdah74Csj/SjGkrlyjT0sbY5OmOST6TaiHepGoWF4sC/6o47RbuH63r
	854/xReip4evNM/OWpQXj4CkwDckr+PE1qmM1Fg==
X-Google-Smtp-Source: AGHT+IG/7mJcAb8OY58kd5KjEdDwKiiPxt64fBsAAxByw47GLrV+ovlf20NvU/LB6WP2ctWSL5wK6w==
X-Received: by 2002:a05:620a:44c8:b0:7c5:562d:cd02 with SMTP id af79cd13be357-7c75bc6ace1mr1248446385a.41.1743633167623;
        Wed, 02 Apr 2025 15:32:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96cf01sm3584685a.55.2025.04.02.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 15:32:47 -0700 (PDT)
Date: Wed, 2 Apr 2025 18:32:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH] cxl: core/region - ignore interleave granularity when
 ways=1
Message-ID: <Z-27DR_D47HkuR-6@gourry-fedora-PF4VCD3F>
References: <20250402193443.944654-1-gourry@gourry.net>
 <67edb335dea8c_1a6d929437@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67edb335dea8c_1a6d929437@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Apr 02, 2025 at 02:59:17PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > When validating decoder IW/IG when setting up regions, the granularity
> > is irrelevant when iw=1 - all accesses will always route to the only
> > target anyway - so all ig values are "correct". Loosen the requirement
> > that `ig = (parent_iw * parent_ig)` when iw=1.
> 
> Can you say a bit more here about the real world impact like we chatted
> about on Discord? Something like:
> 
> ---
> The platform BIOS on "platform-X" specifies a 512-byte
> interleave-granularity CXL Window when 256-byte is expected. This leads
> to Linux erroneously rejecting the region configuration of 2 devices
> attached to an x1 host bridge.
> ---
> 
> That way distros and platform-X folks can flag the importance of this fix.

Would like this inline or just in the changelog?

~Gregory
