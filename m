Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88262FC880
	for <linux-cxl@vger.kernel.org>; Sun, 17 Aug 2025 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450256; cv=none; b=Pqk7AKHRk7vE4gffeDV6tD9hgDvwZBpUZ0HI5MFAxjCgsbRTRA1Mh+0HDmMtFqC5t9762UTAxuGR1134xUnUk8ICrM1FlU3fexOK4eXPO0tnmTXL47iADsNbc+GSUxPdUT2pMwdDHGB4hGmh/iQoE+LtJ0uplDCWbPDdy2pQG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450256; c=relaxed/simple;
	bh=yMiSu8+CwATNqA0jqeNPP2G+Vuy2X0Hp59x65+/AEpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve3Vsz7tRj6C8S/zddmJUj42gi0cEDduWEy7s77a0ne0v8wYTU8+27RquFv3XhNgUr43uhdFGUigdpZL924tO2lL3VKDIuRdAxwEQqWtotjecKcyhyC30gDRR/IMzTXokAsfSyh4wNOwge2e6G6teegYP4GTFOwK4MMv6rxjGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HWtQ7fLK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HWtQ7fLK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e87050b077so496873485a.1
        for <linux-cxl@vger.kernel.org>; Sun, 17 Aug 2025 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1755450253; x=1756055053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTY1FVq5WoDfZQCECYiNgPIc5/Dv8Hx0SVT+yGcGAKw=;
        b=HWtQ7fLK2pfzdh7dFNWX0qRnmOqs5UQ5tHjj2rtKAVB8tULv+uOXfGAow1SjyQRTtQ
         DNOnAShbzAeMYeOhqEswwtL70eNgE++dLWpTQ5pAuIPoZ4RDUUvAvhAsdg6nBrWe7L/C
         LvAieKlSgeeMiD8g4hmo80kvhq/ML5K1rJrWF9nUvFMuKdrlEacYsNSa28bdVbK8d2R7
         YR489yWUDmP9ovQnZ7y7Pp0H+tG7GtF60COHQeGUanikM7Ki9yCTCx1iPhSaADiEea4M
         2JW/oD6ArlpMQdPUz3a0ebIacpjCeWAj8U7lBgzNoQOOD9jp/1DxFYVveupINjnZySND
         bILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755450254; x=1756055054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTY1FVq5WoDfZQCECYiNgPIc5/Dv8Hx0SVT+yGcGAKw=;
        b=qzxxA5O3WJrprbQXsvKElW8qtV/nWzE+sitfJOhXXY2S4UuHP/NR5OZLbq8X2K1pM/
         CUdQ/fVtxgGiilEjrxr7A6FUYu68LxshhUP4um3qBSJPZBxoGTUJsfPG6yGdB/tsAloc
         ThjUDZKmzFusSuZGXIzGo/eU1NiNJ/4O+ZM//Aq1YEPAMbwO7oPp58HJ7Kay0fmbUg+r
         4CYY913/UP8xKvatDKNHFCop0zZkDYvj9q/ajQ0z8Sy/2JBBN3+GKI8XNsWwd1pVnwxo
         CA+LioaQlwN5CDq324rRCi+f9BWcs7DAyo1JmZkpDgQKKQVGHWNCMwpComj6O1bc+Vve
         O7/g==
X-Forwarded-Encrypted: i=1; AJvYcCUYT2lKaeWiqBJQojQ5moVKXOY5WgVeg3ctwN3zkmJigqJB9aeEx8bQ59aDs2hucYVNSuQe2N8rGcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAxdpI2sxkiC/uIjrHNMBCW/FDEJFxcrnedSRcORv9o8c9qSI
	KJqZ8o8EUgLTcefdQAxbWCfp9K177NDEJJhOqYej2SAPlUOnCMwdSVQvdqFOaXDVU0I=
X-Gm-Gg: ASbGncuwGRTzhCN3VYeMjJk2Wtr2UTTq+Brjifyvae7NlJP+J20w+oa0SM+yaVYaDWQ
	GZaipZqeCnBMIDkclpMNHU+IRvd4iARL7oEEXYfm3KOZcO0mIeS4GdCFTZhAXyT6JBm+vkkVH3P
	SQ7LmW8dQZc5gyHoaPnlz1vFWCuC5DOdQf9sCSGsyNwycw44L5bk9VzZIloZaXqf7N870oXr4k8
	DdU/n1IFZV+m95iJGvNWAI805BmpPklbwToBYnDU1kLFt19W6wxUP8b5RJ+T/xU63w8i155l2cd
	S0vOtkS6JUwKrAy9to07hG7qErrZzX4OpWDhvDP7QDHrXvusiPRo92P3BOdV3QRAc+4IDwh28PW
	ISULCQ6v1Fdi0No1g+6R//Kh7jR1BvmKBlplVVgQ6n4srKWYWpmP0uhXN
X-Google-Smtp-Source: AGHT+IHx+kOBv3NDxYTEUEXjNrbq1sQssAeYaYPTpf57jYhOiKKX1UR6U/rAq+fbGEMsJYFLovCD6Q==
X-Received: by 2002:a05:622a:5445:b0:4af:7eb:f4a0 with SMTP id d75a77b69052e-4b1336ee522mr38590451cf.19.1755450253523;
        Sun, 17 Aug 2025 10:04:13 -0700 (PDT)
Received: from fedora (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0e9sm39210241cf.32.2025.08.17.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:04:12 -0700 (PDT)
Date: Sun, 17 Aug 2025 13:04:10 -0400
From: Gregory Price <gourry@gourry.net>
To: rakuram <rakuram.e96@gmail.com>
Cc: linux-doc@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	dave.jiang@intel.com, jonathan.cameron@huawei.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org, alison.schofield@intel.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net
Subject: Re: [PATCH] Documentation/driver-api: Fix typo error in cxl
Message-ID: <aKILiuYaijqAZvPR@fedora>
References: <20250816183034.7970-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816183034.7970-1-rakuram.e96@gmail.com>

On Sun, Aug 17, 2025 at 12:00:33AM +0530, rakuram wrote:
> diff --git a/Documentation/driver-api/cxl/allocation/page-allocator.rst b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> index 7b8fe1b8d5bb..4ac3368c3947 100644
> --- a/Documentation/driver-api/cxl/allocation/page-allocator.rst
> +++ b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> @@ -62,7 +62,7 @@ Because the local node does not have :code:`ZONE_MOVABLE`, the CXL node is
>  functionally unreachable for direct allocation.  As a result, the only way
>  for CXL capacity to be used is via `demotion` in the reclaim path.
>  
> -This configuration also means that if the DRAM ndoe has :code:`ZONE_MOVABLE`
> +This configuration also means that if the DRAM node has :code:`ZONE_MOVABLE`
>  capacity - when that capacity is depleted, the page allocator will actually
>  prefer CXL :code:`ZONE_MOVABLE` pages over DRAM :code:`ZONE_NORMAL` pages.
>

I have since discovered that this area of documentation is incorrect,
and this behavior is the result of bad reclaim logic.  I will rewrite
this area shortly.


Just drop the page-allocator.rst chunk please.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
