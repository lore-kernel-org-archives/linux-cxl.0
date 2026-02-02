Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F537F0E0
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049910; cv=none; b=CzOqUk3/gpNnSveAUCEB4B0kVZF92adZYCWuu8RB42nrdmdlJm9qXXySVoUU+uH4oaDzyisomSBSUySl6Y/CmVvptGHsAYUU8BG+ljb8Q3ampm20hEc1Zso2zYCTmoPEBNo7vmh+y0Amt+drgC1uA9Pzv2lqjDwvEsrqA1kmykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049910; c=relaxed/simple;
	bh=qvi+biXwe6FWM8da1RpTJC4cSYNJHU4QdgNNfQJTM4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2Dg4RwkNK3OjyqMSx0fJ6FGngTTM1+F2Qj4sLkEAAn1QZwFDs9xQzdJ8ut/NzJ/XZYrpd7H8wEeG2wnCqjgmcJF/K/SMH6+8SdGIL0I/xtNtWnSYvkBiURLVLFMxgvlpnPiDuP9gjLqVWN8dvja7iFxq+4s+CqpUEYtJJ423Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hwXU0YuR; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hwXU0YuR"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a35a00506so83219996d6.2
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770049908; x=1770654708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXzbOKFasJtsE3W1t/WL97dojQDtu1zyO4HLMoJcfwU=;
        b=hwXU0YuRDFXF7swuQ/aSR118e0vvKNQc7aB9yiiyCDWiU+u+SD1Zu9eTVjuYJ2KURH
         XOKdst23+jN3E1zTDRyRPnhLP9LCN3vQq+XuSFlnwPrbJvK8vewAw+EsZC8zs4qCyws3
         ooBFsYa77WWSJBuIQ8cZyaXCHdwbct8PV72z5VOiAD49bC8uQnEzCPL8ghcNVbA58Br9
         h6lJfYIafwFUEoLIHKr9GHt6QBC/Jr9lA2vl1d2QK7iHXAf7DLvKAvwv+EdHvk7/U6UQ
         shE5mIl83dqKHvzNC2JIlC1nTb2MQAYaP8fcovtvkFfDAaQveJN8LOzL1jFyDtoT+aUR
         48PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049908; x=1770654708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXzbOKFasJtsE3W1t/WL97dojQDtu1zyO4HLMoJcfwU=;
        b=pcCJQQP63qB41Ir71Ozmr9GYRePcb+KZlBvbyQNKsN7mC+CrAVIlERx9F37ijOZ9Zx
         ZyjtHf8hkvv2SRxg/OetbDAEjApe5/FNbxf5A/b+DgVMhjLbRjKMkwkMLuVv3dsy/ySj
         Ln1t+BW5tX7EDjRriZybIn6gaNGzjRDM5zC9cbaaKPaFKTKYjQSwpKyDB5ey9k09LHv2
         hgJe42MyWtH0FV0nNkIevK83Nl9EkyZUsuvVEJcSAqzmdAmJsTD2/JeKUKc1euJHERLR
         /2+ofJ+G9FpehSz3PHZuPT/coHPDKxxlEaLgo1ucj8UfrHhw6VA7Ums+XZEtr0ptey06
         yN0g==
X-Forwarded-Encrypted: i=1; AJvYcCWprpfHTTmeqodGHs3k8pIaPv36VXQNijVMfXZfP+Ca7xc6PPFHIDtCQhfWtfXXc0cuJR1ouxlDZbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9qaE99AbAKWfD1B7gn0W3IMSHwDv1Iwvnk0q1nHKJZPaIMen
	1V6wM62Qtd1vVvuqHJiokBgEJF4mEOMT6ZyBupAnBj2s7fzMIaBlh4cpovYmqbrU5xQ=
X-Gm-Gg: AZuq6aLCNrhnIBNFEs85Rhhm8EFtNJWwt5jXj/AHF2RE2CcOspcZBsVOxVe/cEQPIvp
	Z4YJ8SRBAqnyHKx2ps9BTIHEzzIUitDLbTZb/jUkz2UfgF8Sz7cKrTERkyTjXxtr1TqcZj791Uv
	Lu3xCieeuTqzkEmcOo35FfY9IwvEsgZen2MoMIDVJJZozKV4qR7QqIUwNXqqDqY4r+4y5Ue8s8O
	SNfaDDGVaT7To0TNMOeuxG0u2BVDCIaeoh7MPROlm0Fz1B1lMEqFfANKo94tJjZuQRZ+Kw9S/9w
	9/qrcXbaa9ogSx2Xzl8qQNNHIR+EMmY6TIWSIv68t+swaONLrYJneQXrHO49Daiv0yhvzLqizFq
	qC2FXlLt+jnKZbuGNxZqso0nH16T7/UJh+PpJsOS3yiat4jKTWynlIUMnvXii2zqdwvWVDbhoA6
	1Sv3Rou+LgaYB5ayYuqwUF9os+Xp9Lz71JL9gj8DISV1LsQyaLQsgPYPc89Mj1LdQrMByAzNSKG
	T8fSeFJ
X-Received: by 2002:ac8:58d6:0:b0:4ff:c17b:5ab0 with SMTP id d75a77b69052e-505d21535fcmr160477531cf.9.1770049907521;
        Mon, 02 Feb 2026 08:31:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c47f0sm134601156d6.13.2026.02.02.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:31:47 -0800 (PST)
Date: Mon, 2 Feb 2026 11:31:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport
 adding
Message-ID: <aYDRcU0dZjwCRb4y@gourry-fedora-PF4VCD3F>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-3-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201093002.1281858-3-ming.li@zohomail.com>

On Sun, Feb 01, 2026 at 05:30:02PM +0800, Li Ming wrote:
> When CXL subsystem adds a cxl port to a hierarchy, there is a small
> window where the new port becomes visible before it is bound to a
> driver. This happens because device_add() adds a device to bus device
> list before bus_probe_device() binds it to a driver.
> So if two cxl memdevs are trying to add a dport to a same port via
> devm_cxl_enumerate_ports(), the second cxl memdev may observe the port
> and attempt to add a dport, but fails because the port has not yet been
> attached to cxl port driver.
> the sequence is like:
> 
> CPU 0					CPU 1
> devm_cxl_enumerate_ports()
>   # port not found, add it
>   add_port_attach_ep()
>     # hold the parent port lock
>     # to add the new port
>     devm_cxl_create_port()
>       device_add()
> 	# Add dev to bus devs list
> 	bus_add_device()
> 					devm_cxl_enumerate_ports()
> 					# found the port
> 					find_cxl_port_by_uport()
> 					# hold port lock to add a dport
> 					device_lock(the port)
> 					find_or_add_dport()
> 					  cxl_port_add_dport()
> 					    return -ENXIO because port->dev.driver is NULL
> 					device_unlock(the port)
> 	bus_probe_device()
> 	  # hold the port lock
> 	  # for attaching
> 	  device_lock(the port)
> 	    attaching the new port
> 	  device_unlock(the port)
> 
> To fix this race, require that dport addition holds the parent port lock
> of the target port. The CXL subsystem already requires holding the
> parent port lock while attaching a new port. Therefore, successfully
> acquiring the parent port lock ganrantees that port attaching has
> completed.
> 

With just a a cursory look, I'm immediately concerned that you're fixing
a race condition with a lock inversion.

Can you guarantee the following is not happening

  Thread A         Thread B
  ----------------------------
  lock(parent)     lock(port)
  lock(port)       lock(parent)

~Gregory
