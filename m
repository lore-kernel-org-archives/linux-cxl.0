Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100318BE8
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112860; cv=none; b=Bmk6E17bvxZzRHD8tR5WyhAD2KKmCZsDn972gsbh1wYjStzBSc/RGaLMxEZlb8jm82/5t298r+uZSda/Ql/nKkkaufSnojr+SLWCYPBEOHfeVscwza8CC6Ct6soCfxa555nIgZZuEHti60imiNjJ7Qg/RcmKY8lVEa2O0ZISHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112860; c=relaxed/simple;
	bh=fHJejXQcN1X2fSXDVj+uSceDu7PKKOLqn6JHGdctOds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT5bzYt6zkCCreWN02Z2kuLjYlqNpGf1P4dmnmsItMS8AqaCaf2V5U6OoKwmEYTX3LPrN4RDfpmSjVBcC9bdAfnLfaCmVtfqF+xk7eUAUvqlMVLRXqm12lFiqmDp6jL9PR50WGPchs71qELcZ7m9bfHnBuglvCf38WwdHLNHobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G977I689; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G977I689"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47698757053so76894411cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 22:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747112858; x=1747717658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J4Xv4mpVu+tFRmLBHHw86CQBLjV7pG83pmr3rKz+gKg=;
        b=G977I689G+iTpVqUWaIgdZmHZTT4yhJ4+PbazoQmGizhV5xZmWOWMtEcEWElvQwS/n
         B/erMyEi72I29P7ap/tKZLuWQp0tPdNCdyC+dL96LWREfH/Beo6tP6vb7Sue3Of0IUDE
         33G3cPmUaFx0mqWt5SH1bT23pgnWFnoQyUN7X4Kf+gOiQOErflik7E/1OCHzT8WOsih6
         vKbXv11700jK08fcTnfKhqKRO8q+snfH4913/k35Bw5rwSAIixCL08x8CvDO1Tla26OY
         E1oIXlvOGovAJg/swlsdxbwxSLh+5oPvMwvlfk8w9ythqnNZ4pSaRjwiF4F8oK1sUK/t
         jshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747112858; x=1747717658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Xv4mpVu+tFRmLBHHw86CQBLjV7pG83pmr3rKz+gKg=;
        b=HkhJfa4UKUHt7t2YmerQHSyMn9Ko/2t1obRW7PNHrqnAuilLqUTP3L3iSZxisVvBkR
         VHOiNX72D6LyuzeYDxJ7ZAoNemGkNw2yvP18je6W7y/XLm2pc4RWDO+maNTKuNstiKm1
         UjR5yKrwvzimjP2+PUqw0yuNtpMyYcSSMtjmsxCQqQt+44dYhE2xrkJZuDzXohBUWIan
         NrvmTIjvlOM7DkTFmSRs0vFsU3w/z/7GDg5CkWwvAStFxIMqZWmiYnoduwpwOOCzr7vp
         XXFIXCOE/gielGCuPVmsnvqGI6nGw1UNQKZAMazRyPCM9CVY34OCtX7r5pUmKRUfrHtQ
         ulpw==
X-Gm-Message-State: AOJu0Yy1G/J9sB8SwiH6bgKh5kQrPxyYQTbplta013WAfVa5GxdOQpTh
	f6+97LRA3CTnpNg2qJqGMlNreuo9M9ByCWkDZDZRsLBQMgJegusCU0MCNpWD/4U=
X-Gm-Gg: ASbGncsUJKaz8pTuCrh7gNqGovc0wL6C/htCdEG6Z9G1FNXYgVj5CSj9b/3LFR6YmMf
	4K5yoQVTauxQaqBA2lTRgZ4tm/t8j5ugmbGbAywJZxMWRLETuWQgv9bwsj+u2LGLj++4SQsD2hO
	V7SvKbRAAYwguA84vfSztpoW9RkLjFdExTdQ6U7TIYEJ+vnQfP3Qu98AN/kAdJBUQcXoNYSyTvP
	1DqyRfD4LmL7hGGbxiazDIpYu+FonTR7vl6dx17bKOwzd+s1wv24nYdqZSIAjuQDFbbLGixhAws
	GxaG7cjxc2HMfF40vfzL7H3ME6LyPQlQRRI7sYuIKX1AD/gQdNp77denTklKTUG0ucgx2VBQ6Q0
	hDNkrg5Gr7/gl9khGUa1HirjUgT5YTx8=
X-Google-Smtp-Source: AGHT+IEIgrz069YJ0UcQFcOvwJ8lYu7JrEeTfbavQ2OUB17upvvUXuoj6wAqEB4WxTYKLDm0Jb11AA==
X-Received: by 2002:a05:622a:15d6:b0:477:13b7:8336 with SMTP id d75a77b69052e-49452736433mr234179651cf.17.1747112857842;
        Mon, 12 May 2025 22:07:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4945246c6b8sm61137151cf.13.2025.05.12.22.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 22:07:37 -0700 (PDT)
Date: Tue, 13 May 2025 01:07:35 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 03/10] cxl: Rename find_dport() to provide better
 function intent
Message-ID: <aCLTl7gWdUH-coeN@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-4-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:03PM -0700, Dave Jiang wrote:
> Rename find_dport() to find_dport_by_num() to indicate that the function
> is trying to match a dport by its hardware number index.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

With the change about the follwoing lines recommended by Alejandro:

> - * @port_id: identifier for this dport in a decoder's target list
> + * @port_num: identifier for this dport in a decoder's target list

Reviewed-by: Gregory Price <gourry@gourry.net>
