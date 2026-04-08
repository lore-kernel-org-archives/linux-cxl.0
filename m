Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D403A0B05
	for <linux-cxl@vger.kernel.org>; Wed,  8 Apr 2026 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685377; cv=none; b=cIzi3N8uYjElKsueAT13Yub+7DTymZHTYY5dcNA465pr/C5MHm9UOqNp/TbWnsMTUSyI3OrSeLVitnbW8E06wr9a5ZUaakeEymXdVCbFswx/3q4RYnfLFf9cvP8jwUPCmlccArFGUqztxxHdjyyujI5P3paNgIck4dv+oOXiqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685377; c=relaxed/simple;
	bh=m/RIsCZ6L9sAmGDRZI2YbyVGhDO+TzeVpIUyc9KH1Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPu5tJaVRVsYKFECfsCzIpapcNsx+09GJKqnu1brue/Ik6mpaiORp9rpbClT4UWJJqaECGnaS+RkXFz1jsPy2kAjwpaqIors2dYSMLvnV4JKe/Pvl69XVIo3oG1TDUuWL1GHyUYQhy+imF+vuETA23Mj4YJDEvjIeezcjlAdMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WbZlpVdA; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WbZlpVdA"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d6249bb99so2254921cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 08 Apr 2026 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775685373; x=1776290173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qndnJttoApFXUO2POEtVDoUfAMGPbRgoP3C1nGgpeNw=;
        b=WbZlpVdAVg4/a8k/okNew88UBd78k8vdw7AVRhZqFjKtpHP6glg9FH8DkicHFEBmmF
         2nYUR1Q73PV4hpYYaPyu9h54xWwfDieHsPxL/R0T1L+6Em4TvpLU6kbf9T+9L3dAURQP
         0eu7WL7hcsvgCIYmUefP/zQ/QokOisRWbeJkVWgICBCNaL8PsB2kFpDnTFcHCLXnUfr+
         byqTf/u0Nl+G09hdRbyXNH3zB8q20LOqdLmMycWdyOBvWiFX2aMR8InXpkEI8Oiwbwc6
         BiipGUfAJGI48xk24nwOgZBkAlREFXVtEqVCXBcrSohYiyzEW7Siqp3qZPTQUnT/mrae
         hCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775685373; x=1776290173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qndnJttoApFXUO2POEtVDoUfAMGPbRgoP3C1nGgpeNw=;
        b=PWdR4eT7nnYy5A2nsVKMfeqt0Wy3MT54mSyMrtPJLT1nqZ0KOX1HBRDdYODq+kNaVR
         EU1HsbQ9yFBxSoqs0HlR4IhFpgCZw5la6yDVl5lR4MYt10xb7fDJVjgAd6YjLemg9cRP
         Jr2A4s616L6OanQDBThO+l0duajtGHDDlG2Ncv01dDIVHTXMxnNWK8NJ1g0K1+1T0xX6
         PcjDWWcx9vv3AD8mMWqhCLVEU5PXi8Q1aTJPs14yuRXVvKud1iEHHI83QA+1lY1EfzJp
         1+O0p9impa/VCZABRK+y+VQbwaiUVv5ck95lX4R28/myQVhV7FM3R2vNbm5fbX7qtez9
         M6xg==
X-Forwarded-Encrypted: i=1; AJvYcCXqrNnHUjwmhQwROZi/i9MMK8B/KemI6/vSUM4gB+lJRO+GrWR7IMAwkRsJD1UsrEAdFKmDDAE51Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQaJzgXa9u58osTVn5nPj95HYB2jQ6hWedF0MgoDYFgAH9qAAu
	EPfXikBqNP5TwpFSjraCU6AuAu3f65z8ZZtl59wq1HKWWpKAadOofgMIrzTuyn61DyU=
X-Gm-Gg: AeBDiev90Qn72Nl1+fAKNYvdhr3VLFPfYoWiZCGMp5P9B/mQP20kYTPEgfkWKgV+7db
	m6tjm97xgIj/VA6/l1fkeseVPd5lfRKpO+d+/x7TMjurWw4uWWiSnqxTJ+Qts1Ygej7xmm1ALLf
	XGSVIrr6cSjUx1UJNtqHD3Ay4TGZwZLJg1HJikVP4sz0RFJGhUc3KDiv0MLXHf0mUSl9snuPokI
	2nCYVO4PB8/gJVLyeII63VK0ILh94vfinoM1j7o8kQIxRpweUC44frFzSn4hSeVkzkdhA4W4ocf
	PKSPGhJd1arUO2tTjHAtO2v4rw/1DCdEYSm5ndOVy5BVi5EHRN5IPk54ppi++WOu2+sbA81cUhH
	CkTfCwFdV/mWURLmXFqf88Hys706ITJ3rv+ejv/sajo+hz38dMV//KNr6LiWiyluqnUmMDsMPic
	BS+W2WdIcwEYdu2tmOURDAyQ8Q9opcVdAiIRJ1fiWcxzBqmLhN0m5h6wPohnYGEadexS5MNjdFT
	GGVupiiOKO8
X-Received: by 2002:a05:620a:1a11:b0:8cf:d565:fca4 with SMTP id af79cd13be357-8d41b8df4ecmr3283687885a.3.1775685373060;
        Wed, 08 Apr 2026 14:56:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392d35sm1601280185a.10.2026.04.08.14.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:56:12 -0700 (PDT)
Date: Wed, 8 Apr 2026 17:56:10 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <djbw@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] What's brewing in CXL?
Message-ID: <adbO-tqwA_MJ1NHW@gourry-fedora-PF4VCD3F>
References: <69d5bf0ab2210_2b3110036@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d5bf0ab2210_2b3110036@djbw-dev.notmuch>

On Tue, Apr 07, 2026 at 07:35:54PM -0700, Dan Williams wrote:
> For the summit I offered to organize a discussion on what has been
> happening in CXL since Plumbers and a summary of the monthly CXL calls
> since. The session goal is present top challenges, address concerns /
> questions from the room, and perhaps introduce the CXL topics that have
> their own session later in the day.
> 
> Please do comment, question, ack/nak, or add to the themes below to
> highlight interest and help focus on the few topics we can cover in the
> limited time.
> 
... snip ...
> 
> "CXL, making MM problems worse since 2021..." -- CXL subsystem tagline

Acked-By: Gregory Price <gourry@gourry.net>

;P

Obviously I have interest in this space, and the private nodes
discussion is semi-orthogonal as I have been applying it to non-cxl use
cases - but i do think the framing of it replacing some DAX patterns is
a decent one.

~Gregory
