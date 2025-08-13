Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD32309B9
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098891; cv=none; b=CneGIBZW0O1IqMUxa5bTuhxlA2DYsoGj0bRWtR9eBZ04SX3eMGVbNJZrzqQvkzQmiLIREsEFF81l8lzJdZwo0Q6yljIwjHTYpDp7HrwCHOMZJUGsmJLxAwlMxmIgm/6yOrsZj9iJ2dwqAQaOdiM6ssWVNmpDZu0aLOe9+1C1y4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098891; c=relaxed/simple;
	bh=kNbQ8bJ7GL2E1FfUR8hcocEODI6mIH2QsKu9td0CiWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoV7TUe0EdsQJwGTxjIGUpf0c67FInsgZgIn9B65DX5CnMjvi+AO6VpsPDg0pdfjx+vR3UI9PcG+klndk260Ua/ELYo9mt8wzLiflI2YfQS+ZWMWDqqcKxPIYvjpSLCgb51xdxST8QIBwMuFwcOiKGaKTWaBpbGSKcNy0FozWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UJsSxcaq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UJsSxcaq"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af949891d3aso876006366b.1
        for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755098887; x=1755703687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utUYEctpaDfJIrNlEZgIBn4zx0vgLha1VJXf5Z2o5bk=;
        b=UJsSxcaqIFqbeJrryNCzOQISVamEVM158oEiY2jwvDVVPw6Iw6bPuxeBX3917QXu1n
         VhQyO5YcfwbWr3nocZZHjXtba+48/SerxhXMrskw3YVsioXVXDHsSo8g6Menh2NWqDmZ
         GpSPfeKBqkencrIuGHK5ku0r0LrrY2py9/bnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098887; x=1755703687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utUYEctpaDfJIrNlEZgIBn4zx0vgLha1VJXf5Z2o5bk=;
        b=Z1IUttyj0C44yW2tJEQ/y3+K8//ltTWoOowKna/B17OnHvCtKLDVO2rtGZ0TN8u0tt
         rPdBaGmUta7oBWQ5cZqAn60NUUICIaFat/wfmhioj6H690/iTHn3fPYEjDDir/hvn9Hr
         q7Reyoqu9nU0Qbv0YZUtvyoMXQF/hicmYdqAIfcaadpiyrry8Bo0O8PaKWvyVqZ+Mspo
         WohmkjaWT0lhebCTjctUGTaA5VqV9sICQAZDoFhxJg75ttpurtG2k92yODFzxBV7ZzU7
         65BJe4r11LlhGcPfM1FCRVLnCnnKVtC/TmaawE6SXIu2K6Z0wKiNcctHyYezITF7EIjJ
         tojA==
X-Forwarded-Encrypted: i=1; AJvYcCV0tmTPGy3E4Zr72rq1q4PA0AakmF9gmodEgTnVM9ECwhI4LNB3m90Lp8DjSRl5JfXbimjiJHwB/6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxamxaSFZrVrfRbEx5C6kgi3rALSWj7K50XaBbhiDWqzOt/0koM
	fZj1kplsrEQCRxEgNC2CO0xlvoAK9dBKAp4DU6u8djj3WBUnZSeoveL8eHA9S97mw3vzn+dgqjv
	CfnE880E=
X-Gm-Gg: ASbGncvROvq6ePdDJNiDg8ivHCqwwq6x+kkL4AJbmhTDLG8OaMrEKOUGs9wX7XrVSGl
	SycimgFnDMG94iKiJfcOTqqux2j5O/ffhoqqg0pa00wJ9bj3eSy/Oy7hvFEiVKRF0TFi3zUFG81
	FwwqoO3Ju8JI6RcdjWQ1GiX++yLOFd5vf/4O/ZjrrkglYl+oO8LvKUiGxp7dFDBmL/U+ng2Kg4W
	y0dG3FFl2Kja0IuJFa4i1opglFkjt9vU92UILhIQHKeS3SnC4Mncw5mzCuuJMsYf0CLMtxKkHeX
	GD+EGykiG1rKicnNrroQDnIPiaSSv0IyhP3yeE6l+PEpL3r786VwlCi3FbS8j8NB+p++eLeceJ8
	uZ5sQ15pExwo8OgQ1dBIF7Ucg9Dsr+zJHliMHjrpvWPEg1pkUTwL6i44WKepcabIKjelUAdaX
X-Google-Smtp-Source: AGHT+IF7UXDZ1EZgJ5WvDnBZ09AF0nKw2Ls63aOJOLv1bZ19qDCUDBPyOHkqVL7fdxFfeMiCAVi0mw==
X-Received: by 2002:a17:907:86a3:b0:ae0:de30:8569 with SMTP id a640c23a62f3a-afca4cc92e0mr331927966b.1.1755098887153;
        Wed, 13 Aug 2025 08:28:07 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911567fsm21535439a12.61.2025.08.13.08.28.04
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:28:05 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so8281654a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 08:28:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/2S95rp4PL65rdv1uWHHs28ti1oMoZrIrVBAQC1eg/xCwJWkN/2Ek4QRV+zozVr1qvHYK2DCBlUc=@vger.kernel.org
X-Received: by 2002:a05:6402:2546:b0:618:4ab5:e85c with SMTP id
 4fb4d7f45d1cf-6186bfed0f0mr2863094a12.34.1755098884496; Wed, 13 Aug 2025
 08:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804220955.1453135-1-dan.j.williams@intel.com>
 <20250813141346.GM4067720@noisy.programming.kicks-ass.net>
 <CAHk-=whiz9EY5CCHPtRkAuX0wMHwqwa4=GhKUee83mMsU9R0rA@mail.gmail.com> <20250813152142.GP4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250813152142.GP4067720@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Aug 2025 08:27:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh63uw1YO3brwJpZqL2gtBFsM3vycZuAG1vGB60eLZaOQ@mail.gmail.com>
X-Gm-Features: Ac12FXzAQIRCxCMKXtU5LNQDn-555L6LNyKadTH4naeqp0E9Nvd70GKseVpXELk
Message-ID: <CAHk-=wh63uw1YO3brwJpZqL2gtBFsM3vycZuAG1vGB60eLZaOQ@mail.gmail.com>
Subject: Re: [PATCH] cleanup: Fix unused guard error function with DEFINE_CLASS_IS_COND_GUARD
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 08:21, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Right, so I've had patches that added extra #ifdef gunk because of this,
> and we've sprinked __maybe_unused in a few places just to shut this up.
>
> I think something like the below will do... totally untested and all
> that.

Yeah. I'm not convinced we want it even at W=2, but as mentioned, at
that point hopefully nobody really cares.

             Linus
