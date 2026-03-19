Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69EF38F24D;
	Thu, 19 Mar 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948949; cv=none; b=uS0tODDweeGaX1zj2vzMBSYV+KjZhgW+78J2KRWCK43fjR1uhsKMPM2FgLKVncqQ9f5dSswrjNF8WpLvNIo7xNiJ6KuDsKWQp18qt/qu0u7SWiffbJw50sjgFzkd2edR5oL4UMR57JIiLnoI17LA3JMaOBIZcPx9tqe041gIuHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948949; c=relaxed/simple;
	bh=GkPy7bpVDPzleX/dLk9OzmmYAqxzP1zWvyUhMm09gVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnDY7jmIZ27GFR8zfyzQzOvwaxCxQuUnKmZz64PL+I0Ewwunt9sWF7HB3NmZEYUZGFr0BrFgJiVE5k6ulYT9vZn+Bb8rar+K38GM/ZqY6GyvOl0/X+G7JB2scTt7FiUPrNlBibpg323WaST9aigV15mOslv1mXsC0F+sL3MDTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpecay1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpecay1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6001CC19424;
	Thu, 19 Mar 2026 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773948949;
	bh=GkPy7bpVDPzleX/dLk9OzmmYAqxzP1zWvyUhMm09gVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gpecay1/Nd1SFqKjJCFUwIJ/x2+UjLV+zrxL8yQ1TTQ6PvFqcJml+CiO81Gh5hpbD
	 GQSdOCTFhWiw0DgD9kHeppcRmi38+a+U3fH/3WFhPZ6AT4kIgK5VDkTcI0JspLnF7Z
	 1I8Lpr9I2gF+Hu5L4UKJBP9yvncTNnDeEZmZ2ji4N8xX3bGNPVok4bR9XjEX6mOTmL
	 EdD3euegiw1Wm0FPxZgNjcmUYl8ekEi4RASqNtRzIUCVBFiI8xdTbBahXQV/0ZYyq0
	 maE9pRilS+m/Eq1YQh1PQUk/oggDugIQZeLzBntDlZSVzwj1F4HQW+w92GpwG/ZQFc
	 8KrF4TPrQb74g==
Message-ID: <96a0e49e-4b35-4e6c-a3f2-70891213db18@kernel.org>
Date: Thu, 19 Mar 2026 20:35:44 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cxl/region.c improvements and DAX/Hotplug plumbing
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 David Rientjes <rientjes@google.com>
References: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
 <4d66eac3-1a2b-4d9d-8a9a-529a19758439@kernel.org>
 <aXLAtVZ_bVwF9nBG@gourry-fedora-PF4VCD3F>
 <217b154d-e4d1-4824-b2e3-fea82bc44402@kernel.org>
 <abwS5BK0erHVkKKH@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <abwS5BK0erHVkKKH@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 16:14, Gregory Price wrote:
> On Wed, Mar 18, 2026 at 09:53:05AM +0100, David Hildenbrand (Arm) wrote:
>>> and would change the sysfs pattern to
>>> 	echo regionN > cxl/decoder0.0/create_ram_region
>>> 	echo regionN > cxl/drivers/sysram_region/bind
>>> 	echo online_movable > cxl/devices/dax_regionN/hotplug
>>>         echo dax_regionN > cxl/drivers/dax_region/bind
>>>
>>> and gives the user a chance to configure a policy before the region
>>> is pumped all the way through to the endpoint dax driver.
>>
>> Would that still be backwards-compatible?
>>
> 
> I've since squared this away with the CXL groups, the answer is a
> different probe path and leaving the auto-probe logic alone.
> 
> I still need to re-submit the /hotplug extensions here as an improvement
> because its useful - but i've cleaned it up considerably to avoid the
> cross-subsystem nonsense.
> 
>>>
>>> For most use-cases yes.  For something like FAMFS (distributed shared
>>> memory), one system onlining a block as kmem could be potentially
>>> destructive to an entirely separate physical server.
>>
>> Right. But shouldn't we fail this already at the add_memory() stage?
>> Sounds like during onlining is a bit too late. Conceptually, the hotplug
>> as sysram was already wrong for famfs, or am I wrong?
>>
> 
> Mostly this describes the baggage associated with auto-hotplug path for
> all CXL memory, and the fact that we only have a global-scope auto MHP
> tag.  I've come around to better solutions to this problem.

I'm curious :)

> 
> Thanks for the read n_n

Sorry again for the late reply.

-- 
Cheers,

David
