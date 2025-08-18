Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2D340D86;
	Mon, 18 Aug 2025 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532960; cv=none; b=ESyBMEMfC0ygTysgaoeC9LUuCTBSsEulyO7OKsMcsqqbOBpuk1FvkHi0T6BqWvTHbumQDOhbb/qBes/wYeZtcJRxOzHRjtT7Hr3BxQBS5DIjOPUfSfH57IOn6Pn4Cw+l41bwIyC0r08AXM5IPHTALHhDRH7Ugr3Oj6q0QO05rdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532960; c=relaxed/simple;
	bh=t027B0rQp7JsYSyfU4NtKIBv8WrWkrLSL/nQx0S7Crc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GmmEN2PZXXW4w6Db8iLJFjbQgL1X0+mnZ+aCSEVxmJVg3nM3eranMCeWHdsAVLZW/5xNEj+BNJ6NaRqtKIAPsYgXepSA/d2lt270vyNh6VIPW4CR6rYjUuYYw+R0h0WJZteY2evKmGXCYQp1z34zoy8VjNY8w4l2KAjEpZ/JcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CNKEz1Uz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CNKEz1Uz"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 70F3440AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755532954; bh=1aJKByTDq/tn5iUnOzjI0JX85JLg+1vr/5QFFZWyVP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CNKEz1UzV5fvbkyLGgXLAqJKhUw8VOLcRphTroIrXt59qT904MXjtlfZj8oQEabNt
	 lCo1j3oia8E+BFR2gut8jC1XajvxJRpXe+sUk6d0C2pGw9uOWCjLqoDaJuXfJT4BmV
	 PKCKYLsafsb6YBSKzUD8aadwZNX3dNCcnMtVeHx0pDExjBezQSgUwMevIV6I8rHxqE
	 +tqdWJEVgcQULRs68e3I0n7oZGz+DIzmouZ50OkPMoopvugn584ezYV2/6UrX5Kx1S
	 6ouOL2Qrk/zUtHmx/G0o3P3+SDKuw+5wvG7zulPG0lM2TtI+zh7iECkMTAZAY+DMwo
	 IQdLVqYRZRvOQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 70F3440AE3;
	Mon, 18 Aug 2025 16:02:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: rakuram <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org
Cc: dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
 jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 alison.schofield@intel.com, gourry@gourry.net, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, rakuram.e96@gmail.com
Subject: Re: [PATCH v2] Documentation/driver-api: Fix typo error in cxl
In-Reply-To: <20250817173355.6615-2-rakuram.e96@gmail.com>
References: <20250817173355.6615-2-rakuram.e96@gmail.com>
Date: Mon, 18 Aug 2025 10:02:33 -0600
Message-ID: <87a53waa92.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

rakuram <rakuram.e96@gmail.com> writes:

> Fixed the following typo errors
>
> intersparsed ==> interspersed
> in Documentation/driver-api/cxl/platform/bios-and-efi.rst
>
> ---
> Changelog:
>
> Changes since v1:
> Dropped fix for page-allocator.rst as requested by Gregory
>
> Suggested-by: Gregory Price <gourry@gourry.net> 
> Signed-off-by: rakuram <rakuram.e96@gmail.com>
> ---
>  Documentation/driver-api/cxl/platform/bios-and-efi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your Signed-off-by line really needs to include your full name, please.

Thanks,

jon
