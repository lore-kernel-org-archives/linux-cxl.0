Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399436BCD6
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882042; cv=none; b=Ia+VChguIYc6lpFt5/4av+qT2Z5DyU+WfFKDzx59Z2eDStwPW3xLGZugDWJikmaSXlRuvzj4qHsJMwjgQR/cURY0XQ0IUM7xy/IxIY8yVsHD8P0M/bZKzioWn4NbXBhAqp66/0rxj28bbaxFHuGEPcn6fKTFFMH2RCercA9OxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882042; c=relaxed/simple;
	bh=gUPEQwKoAVJtvdwCMMpnTMpiul20lxes8hmhWCNVcQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SC/+DyLuTZ2sxli9oxiowdZO63+KzR3WpWrNoGUVsLprz6onf/cU7vf4vTmbncqfPUZPQVvuavoxSGxt08IYqj1NVYHcvX2Ll6w4MfIfNNsXZRsxq6ccnY8EYUyEskexJMhPN0V+pFSFnHsNAIURacCOVAqcs9vi7cJIUk+HWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UwQ4p0q2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UwQ4p0q2"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506aa685d62so27648401cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771882040; x=1772486840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rGa/tYaawBHc3UPc5xbnokW5KU/4eVYtJose4EocSc=;
        b=UwQ4p0q2U0pd1g7hrpohae5vd4fhr7dCYXSZjFyX7Figj/oiAwUn2QeRq3RVlu24Uo
         CmRjbIQXTLnJ59vcVJt0YO8umrJrzDC+0ejUGjE/BtK93s4eJ6QEnO4vqgXa5eX3kpg+
         W3P28+LLRfhV3+RO/bjeOh/MZOSIwGA+JtlYjSSc9uFjsEAMnW9zpkAoMhhaqal7MWun
         MP4QmHRRQLEMj3oy+kwUd4HDvhyCX/A3QFZFrzZK4OQdJxLzBn41w9sORdirc29AJSx8
         CF1h78/ryEEWlSMzdUgGV3Ewta/11Q+DBIVmG1OsH6OzNMUWTiJs4FRzG7zM2Thyd1bG
         17PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882040; x=1772486840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rGa/tYaawBHc3UPc5xbnokW5KU/4eVYtJose4EocSc=;
        b=ZPQc505E1W1Vt15mLrS/UuC1unAi1G0NfJR+5iGUcvO38iNOxT3tXA/Ff8kN/BysOX
         vgaVJlmePlabXMvcT79+sWVNDjKzAXZvSxEUY6rm7YtQTz+jod1OEGEOHU+mfKkLb2vb
         PQj6oslnsLRDq1qOs8iVTbKwbRKKi8Mavhp/Dm7MSL+OEMcZ1k3OsMOTFwwBB3X9ngbk
         W5G3so3yeilai4LxiVdLimFy7O+sjV6p1rr835YvHJItFKBOTXU79k5826Q8dXu+lEux
         Cjq/Q2ATuUhS5XrnNB6Cxykk/R6gm9G41bS0uZlKvxzy+4eTJfzRXyYSNh2yWYmi/v/Y
         P9jg==
X-Forwarded-Encrypted: i=1; AJvYcCVHNejWsEXk94o/N+xLL2S91fC0sBrBkWuHGApIQFL2s/Wwny/98IfRpK1ETEAWAFd5yYH+pCOALis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DSV0uZENUxofGYad5/sg5xRWPcSIqMpx6jdUdNHsnl5frcnk
	M0cURlaZ/GRsHPSfxTaIZPRQOiqiMBcu7or9hbrJkX7WcRrebxZoMQjQSLIuS0Mp7bNl4wRKMzK
	jKyV5
X-Gm-Gg: AZuq6aJGbiTVvaYuX+6yxAGUS6HRx9d4EjHNWN17CzqHDVcnCrO4TemYL6z2q2IRCVD
	qbDM6tAq/iBzXxUMXtACoafFUuAnBk44YNAFt2AJ2o+jykerDihVvKiJeRGMSeV7J+7W7ewJOLW
	/ZnNarNSpffOPQllRQlvV7ZAoEJjIAY8EQwdXyMhP5+TWtEiJn+tjqtfC9/hlF20pHn59zpx9KD
	est1R6dy+X/3x+ZcGptJPlI90OhhSW398K3snLElD1/Gw6ZCXdFl5LHd9QlhMyKtwbIa/sH+nJr
	6kzil2dw2a8dlXL1lGe0qnN2WjZIupQkab4BjX6JR0l5jyVVZytCsDCrDawTEcY0xLxjJTEyvjl
	A8RFTDiUz+1jlHxpN8Kmf7Wwi6mjIddlfBA6MkkNGRgmJGAMAodjGQlMkzcTWnFVJ0mpTRIOQq0
	tccvvXXFazG4BKlcKIbPuV1J9AGXp6Xhry8NHC5peo6XmAURRQ89RANLvn7vYFU7HugxexpmLDc
	XfUG2VoEA==
X-Received: by 2002:a05:622a:1208:b0:501:4703:3b6a with SMTP id d75a77b69052e-5070bba1423mr127301791cf.9.1771882040469;
        Mon, 23 Feb 2026 13:27:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6c638dsm78450051cf.25.2026.02.23.13.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:27:19 -0800 (PST)
Date: Mon, 23 Feb 2026 16:27:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl: Test CXL_DECODER_F_LOCK as a bitmask
Message-ID: <aZzGNiMPuU-Jphou@gourry-fedora-PF4VCD3F>
References: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>

On Mon, Feb 23, 2026 at 11:13:39AM -0800, Alison Schofield wrote:
> The CXL decoder flags are defined as bitmasks, not bit indices.
> Using test_bit() to check them interprets the mask value as a bit
> index, which is the wrong test.
> 
> For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
> the test to always return false and allowing resets that should have
> been blocked.
> 
> Replace test_bit() with a bitmask check.
> 
> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---

Op, missed the v4 and responded to v1

Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>

