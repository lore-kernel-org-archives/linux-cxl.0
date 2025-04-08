Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525A22B5A6
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124665; cv=none; b=GiPGEH2GME1O4HcL9BbPWGboQBungAWZGKS5NiJP5SqBqO3QUtI100V2h9qiu3a3l4TuDisziVZfLtOTnoLWMFWwZ5ef5ssO738hJTANrDsEF5sjAndd8KbQjdWCx64c+CJR1DrJ0AhCFKmCFpT0gbsxtKZkIbkJdxmIbfoYLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124665; c=relaxed/simple;
	bh=BL4lKtl1o07ZcWzehqv9Cnhkt+zarnliLqjB8aGz3VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLEenQ9PIfQGrVtagRJGykaV4c/WTzWgwVG9lp1cje/6MoyyDjl9lOZ2sK8rgjCNRT9mzVkCMItq9pC0DaIQA3WgxsMg6bzF8N+1yf3i/4X8pA6QPT36PhHSVwOIqkZRyb7vYN+MHSY/srk9HOR2YicAdu7grkWbPCaO3I4qIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Rz3eBcG2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Rz3eBcG2"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769f3e19a9so38317191cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Apr 2025 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744124662; x=1744729462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsmsgzWLL6kVGqLwoLfULN5GphZA4bLGRgW5AWnpqp4=;
        b=Rz3eBcG2hghqZAHMH8s6SMjcCTM7B4o4o6b174XrI7z8zahBx3b7KL+2jBcSmbeF16
         i8AGO5QZ3hQDU/2VMwYYlMnIebzLXYXHSSwalrlMPDGMOj6lHrOuWtFafPJFpsPZQQqt
         98EsY04U0N5DRopI+EArgfvbHIjpXYnHPzM+xlo/SX2eyG9MXHMMaqeGusgMaqBZx7Md
         vsJujT2bpIlXimxj3G2wzqg7I3ktLwQQM0MRkZnFdkOrGJkM/JVszUmQoURIVNz9VLn/
         N02B8+O14M7gZOwUKLyzC67EN+APW76Zzn4TVqN+0vT2R9+N72owRxupzay/PAt0ZOtv
         esIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124662; x=1744729462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsmsgzWLL6kVGqLwoLfULN5GphZA4bLGRgW5AWnpqp4=;
        b=AQ/lPo6iN/DA9tGm3muNi8hwrjQHgfdaXFpvl5FmkLUcxyTVsO3Ba4fwMYwtr8hw+1
         B4znEro/h0rSGjSYGr26cGnCiPLAGG/Q+Cydd7GGviBLpRydnx8qmfr1skKg8rBH7awR
         IS2dcOX3/efkoHqH9qU87+Il14FK81esHIEvylTNIv5pcfE7w2BBCfUihue0eP23MLca
         WU9N5/uIRzH/QxQJMqc2WkPbbE1S+20alv6xogeLaH35/AMTnCna4H+VwRNKsr/aojlr
         WvGiVOCp2VKKm6UyNWzcei6gLwokulNgM7BicpLrb+CZtQrNiGyru2bzt+NyI5vI0dwr
         WucA==
X-Forwarded-Encrypted: i=1; AJvYcCUnBXBD2+Bir6LUuaclA9djQVOYEiNQJ032LQtIHFp7YLVx9vYnL7VKk8BUXrs2GCLObzekWt8Pm8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6lwzuHtOPr7S6Kxf1Xisbw45vU5gHSfUsV96CJh0aNDovT+Y
	bAr/8UtfNLSw+yhMRkfDoKed1pricrAcoZvQeiv5NjNH2OE0e6Qny4TU86Q0aGg=
X-Gm-Gg: ASbGncswlZkALmf4o27NRJxrTK+td3heST052A6stwRf40/Wj+zSu2UEkjUgk0ZOw9I
	mcCDpoPgmRtios3OCviHALRGp38IwkRd/06opBZy6tpfGCaBBGyiz9tFl610eNswnk1veWZf0Fe
	b1l0PrL5tPZxIKvj78Os3xCoWJ5OqoEr47FAOyWExwvEmZNISdQJE6M6OHw9JN0KJxGfnxKjZf8
	advD3uTg+uCrZ0HzSpswg3uJcCt/WBHp2dklMNM0KDjeLAHIU6cYamW+Bsctn7UM5Z9M3Ji3jzD
	pXso52SW2TDbjUGimjhjZhZ+7jOxpqeepgCnD1B36D51LXmN30QNpeEQaMT+/9mOmmngCUYguzL
	f4BfG3OubChvS+fz4CyVZBwjL3Gk=
X-Google-Smtp-Source: AGHT+IFJtDtsqhqndKEDywk5WxR0Uoy5G4rpBDYAgWzK45UFzZFnH64aH9P06dvjmEqEV3b0o0jjHg==
X-Received: by 2002:a05:622a:1:b0:476:76bc:cfb8 with SMTP id d75a77b69052e-47925991e1emr272565651cf.31.1744124662547;
        Tue, 08 Apr 2025 08:04:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b088412sm77386711cf.39.2025.04.08.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:04:22 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:04:20 -0400
From: Gregory Price <gourry@gourry.net>
To: nifan.cxl@gmail.com
Cc: jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com, anisa.su887@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC 0/3] Qemu FM emulation
Message-ID: <Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408043051.430340-1-nifan.cxl@gmail.com>

On Mon, Apr 07, 2025 at 09:20:27PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The RFC provides a way for FM emulation in Qemu. The goal is to provide
> a context where we can have more FM emulation discussions and share solutions
> for a reasonable FM implementation in Qemu.
>
... snip ...

Took a browse of the series, and I like this method.  It seems simple
and straight-forward, avoids any complex networking between the vms and
gives us what we want.

I'll wait for Jonathan's commentary, but solid prototype (bn_n)b

~Gregory
