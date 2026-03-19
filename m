Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655221B1BF;
	Thu, 19 Mar 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918679; cv=pass; b=GqZ+9d5txEnjdKufzfuCJHF4OwL1FzqwSEUzTdTcEe3M6N1PxAx6jtAvVGgeBXdxLu5vxjCPdsxc/ufyarHkydVGpjFJvz1GiMoiJVoP+ooEH6WRT9s1IfqG3PxPHpwC4gXCuyPikgoG0JaMUFhJRSJzpVHaV2togy6aPABdBM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918679; c=relaxed/simple;
	bh=2D36c8m/rXgsypOcTTESJJfM+DTWzMAvVrUbP+wV6ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3pNtj330kn4tfv/pKaz932PhWx1Ijnwr/797qYlcrA0RAbhX6o20fjHvx25QfP8AhW6L+u2+sdhoxkXs5/6w0AxU23GqyCGdxUvDWMqVUUCirgn3/SbW0P0x5n2bTW0GtjCReoduXJbnlC4na2TrLEsdiFvoFvQmR9v5u/X4Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Pl3HToER; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Pl3HToER"
ARC-Seal: i=1; a=rsa-sha256; t=1773918652; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S9vhnByoIaWtu5ZXlj+XgQOToWc5mjG5VhGSBCTkb9wzz4BzhQImv1F7utGkDVVQL9BWzmPTZzs/+R0z7T5/IRB/Q0Ne5gWQdrbGorumal/SPbjmvnfFPUj44cQoHJNUXJLPApqAa8xasiqp+7vVII6Ag6Nma+gOaCCuQVMyzoI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773918652; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2D36c8m/rXgsypOcTTESJJfM+DTWzMAvVrUbP+wV6ig=; 
	b=fo+5sNmpO824BV4saiugReeR+sODG7Ao1oftiOu1p27ah+3u0IxcC+oP1r/OYoYD3tvQjACFPTgOPw81jmXKUnqJutGEpIhoPW/KPdHPOMdZqWcNtDgiF4rU0yuKJGVAj3uP8NqfwzjFzoKxm2t5xtagd1m7ECG9lzifQeDXWYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773918652;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=2D36c8m/rXgsypOcTTESJJfM+DTWzMAvVrUbP+wV6ig=;
	b=Pl3HToERMY/X89PKJ6aMfMgZqr2Vl0AsKhvILo47hvOxSl+ygf9D9nYbEiNNbXYc
	Mx0O/m/lsquKoFlumjy/qoucgaAxefUI0qd7ISfI8uUifiAawZ13Vga19tFnQLVq1nU
	h6qDA7ZaEInRFVzTfxFy4GwEUQY9PNb68s/gaHxY=
Received: by mx.zohomail.com with SMTPS id 177391865045295.33053714842151;
	Thu, 19 Mar 2026 04:10:50 -0700 (PDT)
Message-ID: <b9dda759-a7bb-4b67-a148-01dc43a80ab4@zohomail.com>
Date: Thu, 19 Mar 2026 19:10:43 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
 <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
 <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
 <d2ed94ec-e5c7-4b6b-9fe8-68f22bd632ad@zohomail.com>
 <dfc0979a-b01a-4c90-8bc8-7a60fb795dc7@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <dfc0979a-b01a-4c90-8bc8-7a60fb795dc7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228645bd5c7d2df4bfbcba2c93f000040e6b4f57425abeb5e714637d029d8d6e680360947ff33f8c552:zu080112272b8d4497a74f60c564015c4e0000a5ba560450a1febb86ae45c596b9e48ab8cf87ed2085b25237:rf0801122d9e8138bbe36b1670e49484900000c41e71daf1e09c125be312925dfeb8813b1ee0ed497689ca6e2bb727637cf7:ZohoMail
X-ZohoMailClient: External


在 2026/3/18 23:36, Dave Jiang 写道:
>
> On 3/18/26 4:59 AM, Li Ming wrote:
>> 在 2026/3/17 23:00, Dave Jiang 写道:
>>> On 3/14/26 12:06 AM, Li Ming wrote:
>>>> CXL memdev poison injection/clearing debugfs interfaces are visible
>>>> before the CXL memdev endpoint initialization, If user accesses the
>>>> interfaces before cxlmd->endpoint updated, it is possible to access an
>>>> invalid endpoint in cxl_dpa_to_region().
>>>>
>>>> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
>>>> interfaces until CXL memdev probing completed.
>>>>
>>>> The following patch will check the given endpoint validity in
>>>> cxl_dpa_to_region().
>>>>
>>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>> Hi Ming, I dropped this patch with Dan's comments [1] and updated cxl/next. Please check and make sure everything looks ok to you. Thanks!
>>>
>>> [1]: https://lore.kernel.org/linux-cxl/69b8b81621e16_452b100e@dwillia2-mobl4.notmuch/
>> Hi Dave,
>>
>> I think there is no change needed in this patch, just need a independent patch for holding memdev lock in cxl_region_debugfs_poison_inject/clear.
>>
>> Or you want to review this patch again?
> No. Maybe I misunderstood the comment from Dan. So we should keep this patch?
>
> DJ

Yes, I think so.


Ming

