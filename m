Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4B230BEB
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569400; cv=none; b=aWmKsGzGvPipHgPL17VzbDyd54SxqgbmcNUF1u/poiwixEt+Lx6jbJMJds67rGMo0wVccxiPB0HmvoVUch9dof7T5kwy4AqgYYlcrfmSAhZ1Hb3bbBk+NCVt6MCoQgaR/i6R+RuZLQUkxR10DOl7qt4qvM2/ri6zSimOjV3SPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569400; c=relaxed/simple;
	bh=9avm0LqOZNotjogzUUyckFvE/j+N5SXlPAiqBtwZqUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn+2qV1DXGjA00yjCjhtTXV7a+cUVcr8L9/x3MOvFLQVZNEQDAlKaON0IB8n47bo2EG3I90LZz9gilGBUlpX9g504YogyUyBrOF8ejrHglIIKSzedkLlSMUuGMZxYQBanYP5ZXDvEiPD96Lj2CvFAhBrIDabJRLCXegbyTDN9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HRqBiFIL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HRqBiFIL"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8ffa00555so50601986d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 21:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743569397; x=1744174197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9avm0LqOZNotjogzUUyckFvE/j+N5SXlPAiqBtwZqUM=;
        b=HRqBiFIL+fmTzqnP91EOuNWsNtsZo1FoBDHKDoMOwQMJTnOKxkOxxLodJ0b1DPXLl+
         pvQriF3hHpBxGE2o//aBLjAyhAsen7/a9K5PDq0m4ogKew+oPX/uH0TIfJ+mt4vnkalm
         v67EejmS425+97wZbbwHQcAmJJcDEbYltE0bpktd5ChyGFkJGrSGZnVQAHrSLRWwMLBM
         h11YtcFTwkIuKXzONwbLFDtAWVwEeGdP55jHQj46OX75hMuYjwjOandpvFs9lf9lrbWu
         kLSkpTKDlKY29rtGJsnnlB2RJ4FGJsPBwzVTLzBSePxq56OTXeFQSgjwM5hbNNR1VsTc
         eoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743569397; x=1744174197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9avm0LqOZNotjogzUUyckFvE/j+N5SXlPAiqBtwZqUM=;
        b=vf2nDFHsj0oLADGUSZQkl+gD7up6dJD1MZvvMuzeCwli4vLdgXlOIlh+4reAw1ibUm
         z4j8YDH/HsqvKtCzbGnE3y/MLXJwtEgjLP4a0th5jODxlhwkWwN+jsXu2JLUZ46pZSs2
         2WTgsXVAj7ypk8+eXfPHmQM0B5zUiob0BQmnZHmgMpyxCuJsfE84OZ1FPzrtT5b2U7Ea
         gLSeUUC+zvfo/0tYnUmWQ7KR70sWc3OwX3V/vkL76n1HOEispviKm3hLtpCA8f7q7qWV
         9RkmNw/hvtVOcJR4xEiXSJLP4D9LZ4jcHgHTSYmXfKPm9Sh2axYaJbhDyYV3rqgnjHf9
         MipA==
X-Forwarded-Encrypted: i=1; AJvYcCVsqIz/a7Bh7G0d2qKOG/MDrnM5ZGLwwkYnL0ApeONt4NRK9w/KadqNEeLRBzSgg5rk58JZjGViBJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFjPX6Gzx2wLzMsress4MOVhT7Q0zIwHZ7xEjMxjRJDq7ag+I
	b7QovDtpzokfKv+EyjZNEtWP8mal9edzAZxx3QmDins6yrTOwr1Z3j09+K4823U=
X-Gm-Gg: ASbGncsf2FB34V1RdeSNgSY2YEVI08UlF+3UT+PyJZ/TXcvBY+myBx2vCKg2jFz2dvw
	QdpXkRnSQcOgMyFP3NjHgi94EqVSPCje6EAiGLFC4znK7dXgZFe9OgSNNauyo+sYCn1mX/y7Od/
	0+hutwSHAGKQr/yoOsmSDkXT4oX3AGxyvhdVVVVhySvVbGD9sS2w3cqsb7vY6Xasfj28I+dDh09
	i/L68GjvzvIQd0q1KWsMAe2QQnT/ilE6GIPvNH8f9bj93LUw6mfFqIYvgqmjw+gX/N2k5+AMNgZ
	XjHBqSu/dVjjLtsIqsafUNUaDKjJHTs3s8UobDGQ96WROm1MogoEy1UBhB/UybbCfRR/7uqRXM5
	Wz7RVVuOQ+hTsmUuc5XOw4jP/Fnw=
X-Google-Smtp-Source: AGHT+IHrhKBTscM2jCOGQCQuvRNnom05HAA99v9sLRDShuoNOC7upoIA4o6a6EuUpMYxe8aKa7cJeA==
X-Received: by 2002:ad4:5d6c:0:b0:6d8:8d16:7cec with SMTP id 6a1803df08f44-6eed6297aadmr271668976d6.37.1743569397172;
        Tue, 01 Apr 2025 21:49:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec96281aasm70706636d6.4.2025.04.01.21.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 21:49:56 -0700 (PDT)
Date: Wed, 2 Apr 2025 00:49:55 -0400
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@suse.com,
	a.manzanares@samsung.com
Subject: Re: [LSFMM] Updated: Linux Management of Volatile CXL Memory Devices
Message-ID: <Z-zB86WcoMEQ9lKV@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9mo5qCpdlE-KZ7P@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9mo5qCpdlE-KZ7P@gourry-fedora-PF4VCD3F>

Slides up at:
https://github.com/gourryinverse/cxl-boot-to-bash/blob/main/presentations/lsfmm25.pdf

Docs Transitioning to:
https://github.com/gourryinverse/cxl-boot-to-bash/tree/main

Browsable Page:
https://gourryinverse.github.io/cxl-boot-to-bash/

All help hacking on this is welcome. I imagine we'll convert some
portion of this over to kernel docs, but not sure what.

~Gregory Price
