Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69B34BA35
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139275; cv=none; b=aev2etGwUS+Uq4afsEu8F143GaH4z4aix1fF4GixLin6j65Lhc9Nv5u1V2A5sl4aJvP7daoJFfR/agyFZ0BY/+3Dy6hNL+WkDzDYs0E/OQPM702MAY1sUBd4bB9eCuSin1XX61Oypq/nrc3T03pmOtE964JwB/pZEd1NBE33+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139275; c=relaxed/simple;
	bh=TwwaXOK3sonOdIajnBL0Jr8Oe37u/wbGtgw42yeCzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD+dXCNEWY3L2HW5uskiKKnHAqR7Wl/ZmjgL1UwSWHshcmgHZ/ZgkLlqx8EbGsv2plUfGggNGLN5pbOKHqJ6LnP3Jw3Otfzn5kTG/18aDtI1WHrcgcikg8zDE+DD1s7Kxl73ZQivfIS5+Mu1Ky1JT3X0MzkCZrf75Ar13MkbQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BKkKav80; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BKkKav80"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8117aef2476so21816085a.1
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139273; x=1758744073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSxT7numZXGRA2nu3cjzvMRh4LFS1koCPA4vP4KspNs=;
        b=BKkKav808YLordxEe6Lc4guZG8Ho5el8RhhJ9xiuOMUbh86hSRavLZx+qJpBYPYpkJ
         PZ1MY1qoDCFsmDne4cM0bs+nPh3ZFW4jlffyTrV92AP0ByASN4ButAXqCXEsnAaDqj2e
         7z+SfXE/IDKSH8AIv15pO7iuMxvVSmSXoetpPgABlguu0ov2eYZdOcc2WtoP2GIS17x+
         Grz3stSzAeWs3lHJQlTEZiSwUEQxfM4oUUVWTdwTRkWGqEw/xg1xJlxLmS3+Haht/NkJ
         KUc3uZT34t3im3tHIzqpfmhfXmilevr3woIQInXZN6j0EvpE6aCKdH9lltP7TiO4mVln
         F8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139273; x=1758744073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSxT7numZXGRA2nu3cjzvMRh4LFS1koCPA4vP4KspNs=;
        b=Q+JeSxYQ0QSX5WuQE0T7Ck6UaPK/8ySuKKlrh/+3VIjbO+rFaQwXZhltAx3Y1LtsWo
         q+crxIg5R6UwF7KtMsxJKHf8v9dWS/nXuNg/k6/lgFPak8wy5Cp/2vJcUaVx6yYBh60G
         etLJs5eLAHuMShPC8+wIHnDlbDzfwHWogykSaTyRblMqRei0iKqk9+KnYNbUSF8cUVN9
         XNKmOt5DSZdxQriOJdAH4BMhnCHkm2fQ0dh4p2349UzbqWCyzKNNAZgEUkvhCjMs8qiN
         d9T1iIb7C+fbRIwaCMiyY2n3heDuQCSUS8WvMIXOAKoZrF6vBCemB89LM5diJvCRds3P
         oRzA==
X-Forwarded-Encrypted: i=1; AJvYcCXZYGYAV/W+y4mhKxCAvt5klnyGO7Z8CsHU+rMYdhE/H6dJ8gypPw5Lx9gavPmyG8nbaD6UmuYPQYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzswo5785Z/rWdZIIqk4MKH1CXmljqFSro0NcKV/6j2rwwI0Fd7
	1ijfyrHrq6K9lnlv4HQl+kDoEJhlETzWp4fUs4SseJ/vJzJAEOA2JDg9PZjtMAwBS0Q=
X-Gm-Gg: ASbGncvwJSohEbhC9gksmFih0WsDNRKeGA11ZTNy+XYoLZODpC2r+LLzF7BJVfAnMnt
	BNr9xCaRInynPrBKk7NvCm2urz6n5a9sgiv/9I70UMWcBGVz1ZpeIfZiDAA/kIE++wi0BCLuxhv
	sji5XbfAUxhM5FwU8y9S9G2dWHFFQaRm3G+rIWZLQVil3WuXFLPQvqQhhcRWpZGQWde0QpFpubS
	T8aCpygTY+4yx1hzlms15os2X/+vo4aekuuTDNgkrJ8Vp5bxUM+GKg9WhixajjERpO04Aavg505
	GPzRAXMBIEQoNlYaAsdou7OSlObaxy1Cp2qumdgMixrcC58T9GAU4ERyE1SZpAZrcFNIcmyd8zM
	+gpJ7RYNS9uz94Fs490kUkkjUts2fcB9pliAOyMVlH91gPxM7o7eMH99M7EhxFGjPQbBoTRJ6S7
	dSbUs=
X-Google-Smtp-Source: AGHT+IEmjqV82SoNp7n42OCyVT8EaETJLcNBPsDQkV8xsdyDLuOPcXo4OKe0j3W+9TCO5MAXSv1UMA==
X-Received: by 2002:a05:620a:28c1:b0:808:bbc:df09 with SMTP id af79cd13be357-83112d88860mr282060585a.56.1758139272982;
        Wed, 17 Sep 2025 13:01:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8362ffbb364sm35793985a.36.2025.09.17.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:01:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:01:10 -0400
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
Subject: Re: [PATCH v3 03/11] cxl/region: Rename misleading variable name
 @hpa to @range
Message-ID: <aMsThkaVNjiXrYio@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-4-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:05PM +0200, Robert Richter wrote:
> @hpa is actually a @range, rename variables accordingly.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Nothing major to add on naming feedback so otherwise this is fine.

Reviewed-by: Gregory Price <gourry@gourry.net>
