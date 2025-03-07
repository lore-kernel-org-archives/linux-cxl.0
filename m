Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A7F20C008
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384546; cv=none; b=hND1C/T+DdwyYTfLfjjmbUXWWudyx7FPvy6yEHE6C0rhX9VtGw3hfh09DmLkRmnpFiDGwc/E7rzTsvoBjEhD1T+y7O+kXW8O77v/XFekgZKB7llhafMkZRogPHyuzAHuW4EftlyIbV4jKPjBaBQq2DP3K45BBdVPdaAZSKbq/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384546; c=relaxed/simple;
	bh=PQ6a56PJCa6pQaAgDnAv+7bVWUzkRJkT96E2SKdd5Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj0fe9F3XuTyCXBDfrgID5ZBVVdloUT66e+tJEkZBtw2vPzj8dzvKWphN0RKc659w3u3DygUV5qGqtc0QAYL/sHAYmjok60G4wVUCNdBQPBYlwTT/b72nkziePRSU6j+vOm6sbnrUDbOsVDMxLukZ1DWeYyeU89ZDHU2fLPWhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T1SOJPgq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T1SOJPgq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-475162ce281so21315611cf.1
        for <linux-cxl@vger.kernel.org>; Fri, 07 Mar 2025 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741384542; x=1741989342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3+XzQZr4mJb/ntKs7XgjgPeymgXMMsNQQtuBtbpbmg=;
        b=T1SOJPgq6CvEQx6Vs7D3eytX5wZHpcR6tmUhAtHSCBehLE4emQdUaTsNMePTpDru1Q
         hGdEm5CioWgEnAPo9f0OvB615xsr3KuQqPMadIOP4jGXaZVBP3QuuKwVFGJYWhrvisnf
         rVmtWu+jejkAgcCgFhbuZMG+Bgwrz7zpEIcVjwO2gv83pFAX/NDDIeLEAkkPms1SfwI9
         RjP31VCO/MCaPf7rZt9cHjgJ44/zB85GFTuoCjX9mlDwea0AZs4SUIBTyK3AZb8TNsMe
         IqhefTSfy2ky31/GbX4TNST2Pwpn7Bj/BF4X3JslDWBVQZTYlLnoRE0MOrbtDJKYrAbg
         OuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741384542; x=1741989342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3+XzQZr4mJb/ntKs7XgjgPeymgXMMsNQQtuBtbpbmg=;
        b=EM9PSB5SBVa3jUdDZxfqaqIqkIWrYctER2Hu881iCbYrToFsyK4HB2q2GpgWvgs5cd
         gboFJqbPH7tMm3kLACAPevPNrg8rkEYcsx4TpID0fMaMA5kLKCTb94ouwJjBF0hV8Qle
         uwQ8pvwl/Kru+4ozJaMJ5WAT2zptxjnGVKzOCxYfTUWonRcEtR+wmhKrMdD9/GNIteep
         MuIQQq5zpFIwVz3pCNUNkEm8hX358XD6gDR2MyLZtxJ3xsbHoliA0oNGUgeA4d1aTXmo
         7fX22Kdmi1CUfFwFPDZ1X6SFkID0a19fANce7vL65FAlI8uuqq6BBZrsu5epn66LrcrR
         4I3A==
X-Forwarded-Encrypted: i=1; AJvYcCVFDy9SjV1zaPSlQXDn3ty+KnHZPKSlnR+OJ3k/djhlStBIylYEdj+gzKFMo0qYuaErJyGcq4lqYVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94MqXidVhJ/O7VmSGNWImsaZzt0iMowMmPu9mYbuFUs94zwY1
	LPlv1Vbl8RX+DqLu8W3UJncoYiSOyqY6AtVLBooP6UUt9SgfwkJCVCpXMVBXPms=
X-Gm-Gg: ASbGncuMWdAu8ZQfNMO/SNXqYh3nHos3kP3ITdRjshSIv3I57WSag1Epfh7LHHtJ0LQ
	w6YDrTVyAkDT/k+FhLUDphcwiyVuSMluRzjiZgLMkKfMBlbQGJUwiKmAj9IXa9u8yM8akgBAJcW
	K3LtQX0Hh/7OpNtJiLRFWgN8RBoH+jOUgBTUA1YPOa+38y9prO8mGn0Tzb/+vc995ifh2aOl6oO
	DGTjbMlUfYoM9Ix6VCXDT6PkV2HlKF3K8PxSziJFsb02vZejbzMFOTwb0PMrUNj5Dm5VGZ1EIf3
	i/uAFybdKi2oNQBS49EvWZfqIW+vYU+VZbQfscYaOU8l2zMQ63z/36Tfnh0XGD3eDOc5pyaJPNz
	7c9NZ0wTDMPSPJenlShEjpa0TEX4=
X-Google-Smtp-Source: AGHT+IFAFiDoXNwXc+tdWOD0pr6UvVfYJOgwKNdFxxXHedC/i7pQawo0el20cjHMA8kbOAdFtgIKlg==
X-Received: by 2002:a05:622a:2b0c:b0:476:671e:debc with SMTP id d75a77b69052e-476671ee8c8mr5068191cf.5.1741384542676;
        Fri, 07 Mar 2025 13:55:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db4fe33sm24424631cf.78.2025.03.07.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:55:41 -0800 (PST)
Date: Fri, 7 Mar 2025 16:55:40 -0500
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted
 interleave
Message-ID: <Z8trXFxJVlYI9LAF@gourry-fedora-PF4VCD3F>
References: <20250307063534.540-1-rakie.kim@sk.com>
 <Z8sXFGBYFlG2Z1s4@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sXFGBYFlG2Z1s4@gourry-fedora-PF4VCD3F>

On Fri, Mar 07, 2025 at 10:56:04AM -0500, Gregory Price wrote:
> 
> I think the underlying issue you're dealing with is that the system is
> creating more nodes for you than it should.
> 

Looking into this for other reasons, I think you are right that multiple
numa nodes can exist that cover the same memory - just different
regions.

I can see why you would want to hide the nodes that don't actively have
memory online, but i still have concerns for nodes that may come and
go and hiding this configuration from the user until memory arrives.

An example would be a DCD device where a node could add or remove memory
at any time.  If you removed the last block of memory, the node would
disappear - but the block could come back at any time.  That seems
problematic, as you might want to manage that node while no memory is
present.

~Gregory
