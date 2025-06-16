Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B91F8676
	for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094879; cv=none; b=ZBBtncmNP/yqzpHrxZWNfR+7tGJNsBJDVNiMt7KKMSUlDvIXUu9UpyaUEsTe4Gw7BzqJ991YbV/h9RwLSfg13YW7+HdIFK9KLp8GY1dEmxQ4iWSM64SVLFWH1Ep8HYS4IZo/URg4Owk0J9xpvZ4DMqWLrdFKiviwPAosg80Hv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094879; c=relaxed/simple;
	bh=LelOrep8BFhkDNPGP79ngM80BpQG1itNZ9WdpzkFM5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi9P3duxFU9nFG98CVKqy+J/66zdnYY/zlxcAJTcXM5AWE+qCNnDQCZYv7eQ5driZ0ztAo4bJXSFPOOGk+G4+/rlZoDg6Sfnc1xlDnoxo/LnyMY8Vapx0jtEG1BmUz5X7cp6bY5BzqFkvMfJEDzhjJqr4ii6Gm4sY1q+UFX2o94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=F+Z3up9E; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="F+Z3up9E"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fae04a3795so51202596d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1750094876; x=1750699676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7HCyyC5UYA2b8c4IzXsIvi20Ipr0wxqzS/03kE5MqM=;
        b=F+Z3up9E6+pxXo3PTj1kp0vCGtqpZkiG6pA1/KZj6t/dBGcfhH4WEpHAq/DwzFBfyZ
         PCmet2Lx0Ra/VW3EPhVXNd8uWGD4fOawLTht51+/1XR+uR/V4FocWthb/zsWNjKfDiBp
         MxGIqmamX8eqoLCFTNiRko+EGsa+so2LVELzfhWYX+vxfefU4AH+2E3EkrJ4Hwxja0NN
         MMcnmhvilgZcwOo1Rzn3m9yiDpiwis/aQ2683nrIwoXUqVOXcRbbzvNkIsO79rpN2k2I
         h09+DoOd8YzIvfzrdXp2ORzQFVHZbZ19TL/g0VnyXRMiDyg8jIt21rfTvxaJfE8KUHyt
         5sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094876; x=1750699676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7HCyyC5UYA2b8c4IzXsIvi20Ipr0wxqzS/03kE5MqM=;
        b=sHchbRF3REjg6O37VnEb0MlpyF/K2RrpUJocHusjVzscg2+EuIG7aqywmh5W2Ky/LZ
         WW7MC4BmqlFcsl3wnNRRc5B+ayYRqmqJ6Xy1yg5SaABcbdnU61yztU2IwfDodhpx3qnO
         yvfdnVyBouz1RPrNf1qk6XqyPQEWG/7mHZPWTTY5rUiv6SkYRsusxIHIkJGfPlva1WYs
         X+80kYCSeT36ID8dPyftbwH6/8bebuYLtlBsjOmIf9VFB03omMVbYenZByi1kUD9NAa9
         blqR/Rqt+V23Wt9SZnIMMf0cDq8kat1rLNF3ne3QshmUih1MFxv9qAaiGp9dwvQeXSDV
         MTBw==
X-Forwarded-Encrypted: i=1; AJvYcCWveJoqCzhoFZF1Y2ioxLeJLIxRV2p5sF7ojIC1hK6UzQskrlpGF7mlqpRVQ/8qrJasifc34p2KQ+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49THOk71fvAqUHR1kE6laCQDzYjIFwX+qSGajqrHonLwTbHFp
	dAw+mTxNWAA5dHovo5hXunqzYk+u7Gugjhvj0Yf/ZoZav4yxt7JfL73Jpvke+OXqIoM=
X-Gm-Gg: ASbGnct8xSTGOhjIU+S4LrCbK5UC8QFaG+weB0LXn1ikbhSSiyWqt6Xs/tblfHG4EL6
	6wqFg88GBZRVNf6N2wDy54iERBGqDFCXR7kA6wjVMhZMighGvbMmbMynQA7xgINQjL6fPnLIGD6
	tk7wD2XDPsgG9bFPwnPz2o8U2ZgkDaVP8TCDbW7MjlzaR66KP+WnKrNoW9BcRoGI2eGHqhH/YnF
	0SHGr7yDQYJWxqQcgX/efhpTk9t78OkFLfnZM9XlwCp0wa48T7AIU1OlcAsqy2Cn1cdCpy6gNHI
	FgZz4XqQy5WrVAk0Da7O/DIis/C6zXsp+Qmo4MtKT3x2PZZgLFo70NhulqS1c9i2cUnm
X-Google-Smtp-Source: AGHT+IFTR01Y6+W1geCwjaW5IfCrLepVJGWaVvo70DuFbzxcMRNcEzZhf9yE9pfFqi8vBf06mSlbhg==
X-Received: by 2002:a05:6214:20a2:b0:6fa:bf2f:41ad with SMTP id 6a1803df08f44-6fb47736bbfmr161414176d6.19.1750094875589;
        Mon, 16 Jun 2025 10:27:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:cf64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c72b17sm53505016d6.102.2025.06.16.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:27:55 -0700 (PDT)
Date: Mon, 16 Jun 2025 12:27:53 -0500
From: Gregory Price <gourry@gourry.net>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org, corbet@lwn.net,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	darren.kenny@oracle.com
Subject: Re: [PATCH] cxl: docs/devices Fix typos and clarify wording in
 device-types.rst
Message-ID: <aFBUGTM4fpwU749k@gourry-fedora-PF4VCD3F>
References: <20250616060737.1645393-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616060737.1645393-1-alok.a.tiwari@oracle.com>

On Sun, Jun 15, 2025 at 11:07:32PM -0700, Alok Tiwari wrote:
>  Documentation/driver-api/cxl/devices/device-types.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
...
>  
>  A Multi-Logical Device (MLD) is a device which may present multiple devices
> -to one or more devices.
> +to one or more hosts.

This is subtly incorrect.

A *Multi-Headed* MLD presents one or more devices to one or more hosts.

A *Multi-logical Device* presents one or more devices to one or more
upstream devices (such as a switch).

You can have a Single-Headed Multi-Logical Device that presents 2
"Logical Devices" to a single upstream device (host or switch).

So please change "one or more hosts" to "one or more upstream devices".


With that change you may add

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
