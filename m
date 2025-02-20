Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D6213E80
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079728; cv=pass; b=D7I8a/V9V3yffpGErVouEzFqDH0CHxax7IzrmQAi1eTyIoZaQBrybkQXnpQEWCn+PDOtQRubWB+Y3SXE7V5TT6CeIbWbzrKcoUGxImWB5IPGai+Oc9/zOZK3hyKVSUI/LqF0siavKJlOSho8cU13BNSUQfLqO/ZiHKqB6v6LK5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079728; c=relaxed/simple;
	bh=ZxzoUUG6hfeUDqV9SySlm781eUjSo7MEk6fjvDwKtnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLJIjYwqpE1b+/gIXp4NLj8K+NWAM8EBQNUDbaN4t3LqOAM17qBS6EwJ1zcdX9DyIlL7GcRjgpfTtnE+sfsUx9lGr73Lz0iwShgcNZJ1UCDnfKMHEjsSLFH/+9IohMVmaG3IMexrjRH6ZiMS1WOgDPUt6CqIPVFSdkStJ6TEfjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Q8lbs3WP; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Q8lbs3WP"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6449524EA5;
	Thu, 20 Feb 2025 19:28:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.105.228.217])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B30A3240BB;
	Thu, 20 Feb 2025 19:28:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740079718; a=rsa-sha256;
	cv=none;
	b=Ty3Mghzi0miGC6XpeUhe52/mOV/m6opuh43o5lKBaNh2WmagPcRbhKd+zfzpg2dI0mnnOy
	uQ/cct9VWGxVNrdRqcbnoqRHxKo8n04qSbPU6m+ExW+uzGSOJ1ZUUk05GKJWgAekwR6xI+
	az+ZyaYY16N7orGaJA2Qoui9zwiEHRDpgtgqypfp63q3hvCZFt4SnwijQ8H5j19GakRwZH
	R6eObBr1117Q/CRH7/1a0UQLhZOwQZqf7G3L7+1baCareMdnLjNIbl6ZowMyr3ePbuED4A
	KArC7tePjiZ4zrptY+P7DJbHUHSkzrMTbqX2NXNsqBXCx2bAwmHr5NUjS+hvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740079718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rs43f06u3/kqNFctU1Mg6NID5i++L1F5G96uS9HCiY4=;
	b=bjobqG7zZZdzrl80i1bW/8l/0SlGW0QTtkXqCyem6HaFuaSS7ikwsn7S12dqntJ+iNAfZS
	QmpcQTkiAjDWZapWgQVh5kwTaDMojBsuU4k+Q81QSkrZcU6Jc7YNQfx8eXaz2To3pxuVVk
	KKJC1c/YZKkrb1CpPGaTrN1jIYIRn//UsGu7huZ+p/CiwuXCXm/FSOQybSF7PAdL6F+Jlo
	XGtWMFCQ5XJJDerk7FdIT52ofOIRGo3NSRY1KNaJDtHDAxVXibDFRG+knVpb/TzWAvKYtA
	9GGafChXJq9tGjVkWqjS34tMOWnYH8Cz14q6RgYMa/CAwVa4EQT/rUXxbtRQ+g==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-sc298;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Power: 7339b4610ba7978b_1740079719221_619775003
X-MC-Loop-Signature: 1740079719220:3703682640
X-MC-Ingress-Time: 1740079719220
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.228.217 (trex/7.0.2);
	Thu, 20 Feb 2025 19:28:39 +0000
Received: from offworld (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4YzNbT6QjBz9t;
	Thu, 20 Feb 2025 11:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740079718;
	bh=rs43f06u3/kqNFctU1Mg6NID5i++L1F5G96uS9HCiY4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Q8lbs3WPaGovSNeZpDEZ3lutprFyHbvY//pM9J+9Pmdls8qT04p1nocCL/Eq1Qu2/
	 4Y6L/AjzpFNFJ0dH8FJHPlfzMpwoTll48Ki1ZiPhTFqfu6nN3n2iwZoIlm8ZBcpruA
	 V2I8GXE8kCja/HiKi/y/Yk6HMpVXi+8prlqptAhSyk84Dzh31Fh7xsnex97uyHn7W2
	 PLFJZvfS5tMsehoZChLRcYyNsNIeNQ/VqFlONGY8iPlQQRPIgWFE8AmtnjmDlIaQjS
	 8RzrYB32/TiX//kee2igduZ141bmTpdQwnYzirv1XmO0bbWsWEZAmRyh37IQJWSF68
	 Ap0IZr3R6Z3jA==
Date: Thu, 20 Feb 2025 11:28:34 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
	ming.li@zohomail.com, a.manzanares@samsung.com, fan.ni@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
Message-ID: <20250220192834.kbkazl2m2d3mssuj@offworld>
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-4-dave@stgolabs.net>
 <20250220172925.000044f2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250220172925.000044f2@huawei.com>
User-Agent: NeoMutt/20220429

On Thu, 20 Feb 2025, Jonathan Cameron wrote:

>On Wed, 19 Feb 2025 17:36:03 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Similar to how the acpi_nfit driver exports Optane dirty shutdown count,
>> introduce:
>>
>>   /sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown
>>
>> Under the conditions that 1) dirty shutdown can be set, 2) Device GPF
>> DVSEC exists, and 3) the count itself can be retrieved.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>One trivial thing otherwise
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 6b284962592f..cb039cfc62cb 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -38,19 +38,48 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
>>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>>  	struct cxl_dev_state *cxlds = cxl_nvd->cxlmd->cxlds;
>>
>> -	return sysfs_emit(buf, "%lld\n", cxlds->serial);
>> +	return sysfs_emit(buf, "%llu\n", cxlds->serial);
>
>I guess you 'fixed' the wrong one?

Yes, I'm an idiot. Will send a hopefully final v5 with this fix.
