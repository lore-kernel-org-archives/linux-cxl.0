Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240ADF5C
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785028; cv=none; b=MrO7dzPVyDy70SEnYTZfafj32Y1rReifJ41B0Y8Dwkc1CeZvqsAvCK18m3pULZab5TyIORW2MamKPBlbIAH7EfZEBNRpEzbXHI8K7jMEgpe6tRZLr59Tk8cusNG6ZbtppzwjjKkJ6s4j90oOyj+k6TVRcpQsxWm/OOgMYIZfCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785028; c=relaxed/simple;
	bh=n8j3DGOLUHU7uRmc+FhLpi4ngVKHsDZJ/NqvWTWKGcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJkPT2RSEZVm3TyjZK9cyMsbSDcPRUnSUjpi96x/xBd5f7P0VftRfb3A9HfcRATjl6U2K+6p1OM7NKYR5ChjrsOgDsvSU0f5L/Eu1Pd88B9iavjWRtLnzlzTDnyhDSXCUZNmFdNLcepL4Z7tvlbYQ6OFqb4XovFful2mLs0cdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q9k7rDL9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q9k7rDL9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b7041273ddso7858385a.3
        for <linux-cxl@vger.kernel.org>; Wed, 05 Feb 2025 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738785025; x=1739389825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JB1QhklLlkYCU54lqW0Pm1NXVvCDDXyC2idxgwvRo9A=;
        b=q9k7rDL9USHXqJYagynqTeWaqNWXooVFaKv4xC8LkdZmIJ/DQHRzFAwuNo6xNgepDb
         Uj3oef18e/jHX/CQfS9WStux1RPBpIxiXz6FeDDIp/5zDrLIqk+BCRUuH89lXkfsyja7
         4fk1twEZBpwHepIzwizC89qadIImAsx1ddtPY9AolaDtPy4EPp2w5W/ZpeTc5RkarUH4
         mwGf5XGH4QAswMR4uLHfo4ffc70w4UXSN1JFgUfmjbwlLeRxXPnI14DaryOXKwpdZ19B
         04oo++rpYP11iN/6HnJ4exH0FThIKopmy6SomPBMtPuFmel1x94fho3NOrYXShmXnVRJ
         6HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785025; x=1739389825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB1QhklLlkYCU54lqW0Pm1NXVvCDDXyC2idxgwvRo9A=;
        b=wgXlR3AWXgSqR4smJ+WcjgqyYsTITieaG0L5jZKJm593luEaQNfTRaFh5qO1qidb2P
         eV3fg3+grhatiGKUR+Ylqf2/JkwH1y/Y8ox8w12S6SmqDezidKrYekNsfQtj8lvdSa/B
         acBHtPMQU10NR+7w6xQAs1gBwZd+NTFJgIUoXvtc2ZuKM6jDGrfazLI/gJrUMy8CCmHV
         fhYjE4N7zLUOEQEAOnPAj0z+HN70jb5/LHSr9NfhdD23FIzH2U01/29Os0PFsi7PmsJH
         amBAWE6UUVnjDWjlCbdE9lPScdBADL8S+mYd0lS5kJoctNfqsUHFqZAb2Vt/OX+tFC3r
         NglA==
X-Forwarded-Encrypted: i=1; AJvYcCWyCxDt1hRVLbDi7OHNzAWmqnn3T3oZio7VZ0kYj1nIxQhOUVYvgJ7zGQYuMnLp3fiQxhyuT0Zc82E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8GsP0ydr9sMeCk0YEncsfUg8P5oN0XHKBfOAc0a+J23RDRDa
	lX23OobNG4bv6tiNRVrYdWUGuT6eNJH9tZ+8s+nuGxfJiX998yJA3NDf79LPvJw=
X-Gm-Gg: ASbGncsQObvGlWF7pEzkeHiBGV+logdlEFl8mftflTQC6HGQPH0U42KENPqQEYoYriO
	/UTXaKIq40jInUzpBqVs8KDLCjLROqN84CdVNmDxPiwgLQmYQOJyejoZo7Q3vrLVfybtU1X9CF6
	9FfZK2OHO1aYytjdIW+ouBbxYQUu/jBPVcY6tHcLYKaLxrh1LJL0FYIROaIr2iHEz52ABW0R2TP
	B/ubxtM0yoMxJZ3QfIGqSXd3iGKjCpdChc9ZYgiXJrJ5upIw6cjdGTQcPjd3SH/TyUDGB1tWlzc
	7rzqXW6sr3KBFZrlX1nCiatYgybp41taQLStmuKRBk/Kg0sJxmmwH7UBsyes/b53ibRxaTeYig=
	=
X-Google-Smtp-Source: AGHT+IGcFSjOMu8RpqfHkHlk/VsaPfJwj2d6oLcZx7tPWUMVQrzAwbXbG3wdktaK5qXTF1GIr6IVqA==
X-Received: by 2002:a05:6214:21ed:b0:6d8:af37:ae5b with SMTP id 6a1803df08f44-6e42fc83442mr59146136d6.43.1738785025216;
        Wed, 05 Feb 2025 11:50:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e42169524csm23923566d6.125.2025.02.05.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:50:24 -0800 (PST)
Date: Wed, 5 Feb 2025 14:50:22 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 5/6] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <Z6PA_hN-3ZtWbhUh@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:20AM +0000, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> to trace FW-First Protocol errors.
> 
> Since the CXL code is required to be called from process context and
> GHES is in interrupt context, use workqueues for processing.
> 
> Similar to CXL CPER event handling, use kfifo to handle errors as it
> simplifies queue processing by providing lock free fifo operations.
> 
> Add the ability for the CXL sub-system to register a workqueue to
> process CXL CPER protocol errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
