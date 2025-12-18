Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187581DF273;
	Thu, 18 Dec 2025 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089333; cv=none; b=CLfmX74yFu3AE0Dlkxj0cup5ilFoUFBW8WH9LyW/JBSVF8FJqTgdC8I9YsAg+ZPaPE1debImtmKHOh/MC9PsWIgSAP11DgX3EkpEBebQgDYVMPKRViDPoYidu3Pf/XpVEUmwUah1VrZl6rPwRrKjYW3cXYSE+R4VPGt4bcjpTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089333; c=relaxed/simple;
	bh=zL0sVCGp7T996SoDzM1UhJ+B6q1alD6EtbOWZgCKfL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL13t0vo49ihYfBh/f0BmOejx22UfKa8G0MHFT50zOq6drg/sTtRDf58WaB6HpYXCt+ZTtOyTiwtycpg3Q7m4ApLJuWaoWNDlYNPdQV7JVyV0o6S2zG5dSkTjYZ9M2BY4HlWuZ/Pc7HX79RQF8RV3CryMBfrfyOxNQAprNZ9tdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DQrT+Orw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DQrT+Orw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7PvgE2cJVmCxPIAJbyf0rCoerISNqQkRslzqpMKTox0=; b=DQrT+OrwErMqcP6cBYSb83malQ
	3ES8/lh1191J/0iYbVUoabxhHxzAAR2GJQRvdVrn0SvLHrNC85H2V0gLmkQHG8YUNHFUOPm2P3fPy
	mgUjrj3qL9NvwTO1te0CEyaUAvWq7F3hLJ9udw+kfYmt6I2fA9k+xeKi4TB4OxTy22Ay5jFZqDtXb
	QWRY0S4yn8wyQxLACZhgJhjtPcJy6HZIIAnL42jY8kfP0VWcFDudMc52TQ5tFW3ngw16qnocbKvdU
	/YRY5I5x1IejKb+Yub6uU3vQszZhPcMAEX3WZZraLfFYO29t8mcy0f7Q+lpdaOultLriR+46aiGRR
	3rTvkVlA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWKVi-0000000994q-0PlY;
	Thu, 18 Dec 2025 20:22:06 +0000
Message-ID: <e57020af-1124-4f71-afeb-681cc4122260@infradead.org>
Date: Thu, 18 Dec 2025 12:22:05 -0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20251218170747.1278327-1-gourry@gourry.net>
 <efc86f10-3255-4132-bae3-8fa6c6dc924b@infradead.org>
 <aURhZQalIBu8-KhR@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aURhZQalIBu8-KhR@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/25 12:17 PM, Gregory Price wrote:
> On Thu, Dec 18, 2025 at 11:36:41AM -0800, Randy Dunlap wrote:
>>> +To add or remove a device to/from an existing HDM-applied interleaved region,
>>> +that region must be torn down an re-created.
>>
>>                                  ^s/an/and/
>                                      doh.
>>
>> and one note: There are several places where you use one asterisk for emphasis,
>> e.g., *statically*. This means <italic> in Sphinx/ReST. If you happen
>> to mean/want bold, then use **bold text** (double asterisks).
>>
> 
> I did intend italics, but if you think it should be bold instead given
> the contents, happy to change it.

No, it's fine as is. Just checking.

-- 
~Randy

