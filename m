Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F72226CF6
	for <linux-cxl@vger.kernel.org>; Sun, 21 Dec 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309169; cv=none; b=nRR3tp35U/f+ao/3Yky3LwHVwCSyEFcrxI7uSH9/KYK1HcE5DoFkJupbbfvfJN7TZ6OQeO3HV2D1i/MnzoDcjyTNRW2x6MQkWKhSl8cnJL6dCR+IiCOWHgLvqOaeop+laO9wY1sbq0j8urk+fK9Gu+kwH55O05kNFyO4aOFLUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309169; c=relaxed/simple;
	bh=esxjetLdFP/MAyCLymvsG8qIqlk3M0nhtMrWkyRPnwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atlNbW9aWjeUwQMRkuVwOxfE+w8UDSkCuiSdOSovd4xhDq6LovS9UpA6DuQAG4ljbG/97cMfUnBjSTxguCf65+/80reT2B2uUabdm5/Qm8USGAmbU2zSrKH1Gz1V6Jw0xsl9yfwUgBsfqggqnQLIMu2FNHrBvEM0VIQqgjrDr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnDPGczr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnDPGczr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09984C4CEFB;
	Sun, 21 Dec 2025 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309168;
	bh=esxjetLdFP/MAyCLymvsG8qIqlk3M0nhtMrWkyRPnwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FnDPGczrrw8oC7l9zuzJWIbFyrodhrnerdPmuBtB0HFe3DSaH4B/S0nHIv4IvZWHY
	 HvMCP8XblN1Z5nu3gVXIi7XDbMja0dstINHmLibZGbjsVgoHlAdNNOkZYbw/+8WAmV
	 lApjz5UCEugO3Ipe+/Dtt09ibNm3FKQDnKSQtx237eIsKPQvai/Ty/rZQG88mpc9in
	 K0sthxp+4ryjgiwfNuFMfqfEM6f99HCff17eATPsFyaX8qf6VrVIggPjiyKK8xcZ+f
	 P9mBPpYLliQrelgWNOl9Ldfubg2Pq7XmUyLWFQVVzYmdytJCf952OyYnwkVrGgEP8j
	 QQND0w+2LOcmA==
Message-ID: <ebe2b0e1-38fd-49be-bb10-af497abf78f7@kernel.org>
Date: Sun, 21 Dec 2025 10:26:03 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Notify the "Device Memory" community of
 memory hotplug changes
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Groves <John@Groves.net>
References: <20251220000327.3502994-1-dan.j.williams@intel.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251220000327.3502994-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/25 01:03, Dan Williams wrote:
> The recent episode of a warning regression in memremap_pages() [1]
> highlights that relevant updates are being missed by folks that care about
> core ZONE_DEVICE changes. Yes, CXL folks should pay more attention to
> linux-mm@, but it also would not hurt to copy linux-cxl@, where most Device
> Memory folks hang out, on memory hotplug changes by default.

In general, that patch set went upstream too quickly. Quickly as in: 
more review should have been done. But here we are.

I reviewed that patch of that patch set but missed this change ...

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
