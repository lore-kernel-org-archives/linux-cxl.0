Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA041E2613;
	Mon, 31 Mar 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743446089; cv=none; b=awGOvE/FZRNpwSSutsqGshb2iy18POCN7zN0A/tnltdQgq2k+ops3HqPSfTKzCJzV6Umz52VtwTM5Uy9kGR6pHvb52VQQjRpjmBGm1X9duZKPXHgMylPgZ2EOhsrIz/pUMFp0gEm/FDp+4V9aAJg+givqBMEuL8WHHx8bdOtsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743446089; c=relaxed/simple;
	bh=OXMepVIZw8j7OSWTWlrANvmMtIsYrbKki78DrAZPVCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPzMfkP5y2DZ3fFMQCf1wDDr0t3aFiV8W+dZaDIQqRpejVP82iervYpVpYGmWSoQPEV/4S+rCdYwWYfO8UvGHjdvcyzyCX1KzR9TO0MA4nykiATQXLeZzqlE5kdxUq2zMVnYU3C8LQbEVxNM+WPbuiOmBQdCM3qupOLIK19Uh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxfYlDE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxfYlDE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF3CC4CEE4;
	Mon, 31 Mar 2025 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743446089;
	bh=OXMepVIZw8j7OSWTWlrANvmMtIsYrbKki78DrAZPVCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxfYlDE3zWfk9gik070bJG8Bw4kMHKEoJJseIVTf1+nTbfA3SX4UmTe6JG0iYrJL8
	 JvjBJnQJynIuJgv59SF6XIJe8RK4hBt0f0U+MYEa6DMfb3VfHfZLoSgAJOof0Wz1ki
	 ctQcQ7DnrH/sFigsszGaSB99dvAe8tyYH9leQ/0WbF9GUZFY2cthBv462WZO9drq8z
	 /dFMZkwz542io/IVEb0H1Ld7028pSQqr+Kyp5KRQXeZeVtO1umNmdhkaq2KAut2tbV
	 cRCGI/wuLr0nzSo9CmxS7zfuI9hYyOmgyxhJ/m83kV8K3gDZUoo3ZAEZ0g+UyfIWfo
	 fnvj+IlJbi6rw==
Date: Mon, 31 Mar 2025 19:34:44 +0100
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 09/23] cxl: prepare memdev creation for type2
Message-ID: <20250331183444.GG185681@horms.kernel.org>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-10-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331144555.1947819-10-alejandro.lucero-palau@amd.com>

On Mon, Mar 31, 2025 at 03:45:41PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.

nit: accessible

     checkpatch.pl --codespell is your friend :)

...
