Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC12B9B7
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863140; cv=none; b=TnMA0vlu74GyJ/AYAarQSRSVfyBZV+nYs3t9Zpxg5Jpb8cl1IAsqmOE/sBA9F5VoQkiFSvSXAacSMG5w20ougTxNcpLw6kz1Bk00y3UflfIIhLIK/M38m14s+pHRFZJ+Dj+Rddm/Vl06DElZmGRCuVQdTmZcowRwANk5ReKK+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863140; c=relaxed/simple;
	bh=qXL4u5HtBh7zMGEdVRYSIwU4cTJd5ZFAEgvCBEfFL4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU2wSJpLPzOW/QpPg8cxcRvpBJSq+ckK/FD5JXrs8ZxAA0nVPBbV3Oh/m+nJppXlV7DDSwIIJOkafZX/yZDYpl6kuIkydij01GrBTJAOwlXMtznmghh2c47EZXLboPzJnVEbXo/e8RwHI5SC5Sx3SNGUOr0k9IFyfybIq/UFWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HbtTq2HJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HbtTq2HJ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e42f82ab88so13144896d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 09:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738863138; x=1739467938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdXR13Nx3/oP+ZXCK66mPCS4i0K090PQPzNpGMGIMKk=;
        b=HbtTq2HJnz8V8lPUqCjTbbkxzetcVylU6mZtZ0XDNr/3uUXPv4q+V9LmPPHlTwPSLR
         1g1NcJftDolMVRPxoJ/B4gHQxdOgvnIbW2+5EGUl/e0RntWkjCmgAj5WmbuujZEW9UAV
         ywPJ087jZCNglTiDHKDU0LoVQp1ivrlzhpUB8s0ceaicD4j56Q/6lD5j3V8Xb1sC7KDF
         KaWKQx73vO1F1f1S6cOCdKG7xrCGtuMxzcKthPBoT7sp273hMe2VSakSVODYvwpyAAvb
         aMVOUQxPWotsD+YiLyetUbts5nc+eSAvtNwpnSWwyNbMS38UYYviyh6odY3b4KY3dBnI
         aYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738863138; x=1739467938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdXR13Nx3/oP+ZXCK66mPCS4i0K090PQPzNpGMGIMKk=;
        b=LMUpeWdmFtwhtJl+0g5JgN+uMsZOehr3uCASsP7kYwGbNuOrUeEiUedPtsjTfSQmtf
         zLtZmQVshC/uR/JQz1TXLJZAHyHpWZ0joCbSfgpClkUsa5IkWSa1NRRc86qr91XWeJvp
         lNB6uHFWPbRjJzbnJ6MXlKv3/2fB3R/0OD1PO72wpduvj+sam0L5e6LvtUhvEa5mye6F
         MLLzx1PspmxAF+3u8wS+r7jj7XwheW1kpFJLn0hK7KbTgv7N4KzsnQhcZEKCm2UnEvfp
         NouDzro0+/CCLcyFI7lsnC2Rx9RrdKqByFnql/TMyhxb5QosAQVe+h7xM3FlWUF8jEId
         qmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3bAjK7NUBDytEyIg9W+La36YoJjIsVeyZGPD0sZkAJMYpsDd/Bvg3xNliIlI9tjaozqsHf9+VLik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+ms3z/th3a7NW+Ku1xB7TDTpGV2aJYOFQOmPocnAdSnIViAO
	TP+hx77RzDADbSrLAXvTTqYiFjqALIWbZejJYzmv3v3dyAgWS2rutUbvKJhUm2Q=
X-Gm-Gg: ASbGncv2yJ7KOCS+Fe5DDJOj/6Vele83rVjSZlMGhe2XfCV87rG6RlVZViWwTOE1ZjL
	3JiAcgIvFvQuu4JfAhZ6kN0xrt8mrSgQssml7mO0bqxKD+ATBKF4J4M5fu+KvXpdEPOLoH4NjB2
	QtEX4Cuvn3XIhXlz/HAOGK4t20ng6jyGqCUZErKzrdgkYSkSybWPNkZUNllQmxuERpIcaq64nOh
	TVe2uRUJl4XzZrNqMXI2IGeElgXbCVi19BjskUzSfUxssGb26E0FJtoXzXpGlYYRyJ5/jsjPhtr
	B71CiP9/DPmj9z+KPI4SqA0t6TCpyLV9cudWn4EH9XvEVfMTcQK3d7bNLlpPsIo4C5I4pnXKbg=
	=
X-Google-Smtp-Source: AGHT+IH+rTWcE0XmrlwB22b0oxWBjkrRHByjuXKCpywQFJ2469+IJXhpsIXyAxZX6kYsM3joAVpyQw==
X-Received: by 2002:a05:6214:5d85:b0:6d8:a148:9ac9 with SMTP id 6a1803df08f44-6e42fc53a18mr80698996d6.30.1738863137803;
        Thu, 06 Feb 2025 09:32:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babbaf3sm7680136d6.109.2025.02.06.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:32:17 -0800 (PST)
Date: Thu, 6 Feb 2025 12:32:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <Z6TyHwbrxTcbhtzy@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
 <20250206105403.00007062@huawei.com>
 <Z6Tf0ZvZMfqth_t1@gourry-fedora-PF4VCD3F>
 <20250206-pretty-gabby-loon-d4e4c4@lemur>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-pretty-gabby-loon-d4e4c4@lemur>

On Thu, Feb 06, 2025 at 12:14:03PM -0500, Konstantin Ryabitsev wrote:
> On Thu, Feb 06, 2025 at 11:14:09AM -0500, Gregory Price wrote:
> > trivia: The last upstream `Reveiwed` patch was 2017
> > 
> > Funny enough b4 takes the tag as-is.
> 
> Yeah, we can't possibly keep track of all the tags people use, with some
> projects getting creative with "Reviewed-and-edited-by:" or similar combined
> trailers. So, we just blanket accept any person-tags (that have a "Person Name
> <adddress@example.com>" format).
> 
> -K

Wasn't suggesting a change, I just found it kinda funny.

Should suggest tag-search on lwn.net to find all the fun typos.

~Gregory
