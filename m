Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC881FB3
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746752233; cv=pass; b=GRn69pSaCtPMKuSNBwv4prVHcJA9AaccsHS7uUakMwFLCFJLMn8MOuv9niFx8bfpipLob/kUvIqSF6N3wYoD8NidwHDksU601apPNhrCLZTRLgOAZhmv8AR3pUhk8ZAt7kR93KgL1AtOjO1Vjl/wicssdXpekHpX7eNwNNtwNDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746752233; c=relaxed/simple;
	bh=A9fD9J9apXXQWG+5+9SE/Apct0XueoWmTBctWd7fEhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osMkkWkeVnWnTVsT8AT1/FFdNHqd03YdpMjEbrwYQrNiD6elcyIb4ZjRvtcP+sHIwF7sv3ISS95wjz5xoRcFmj+b5rnbsGy5ZzRa9Ivb9PY/A5xuAFyYA+EkwSyU/T1WyvhCzSFL9ZfAOXDPAK0WYKvyXCx1nP+YA2H1dFhRP1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IQkwAE5d; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IQkwAE5d"
ARC-Seal: i=1; a=rsa-sha256; t=1746752216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wey27dc1g1ztNAqpVWipckyuXlSlmhWfVQwseoDCyuz4I65DpOJFVg2uuYsAK+0L05g8Dhs0kG2FbiGPxubdGohNxV40pgJfpL/dfpEFMs8Ltvlz9ozdgxa/mkNqNzerT2F1zcBnF+gkFbV68HHST3U9DREL3find8XBaaGXRlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746752216; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A9fD9J9apXXQWG+5+9SE/Apct0XueoWmTBctWd7fEhM=; 
	b=XZtRJkkrDJkTqkxutu4jBGSgMljRGvDh9tXY1M099o/9ONjqjJ8dZSgmqlcWWyOi7V78DUgS3wF6aRpmJKRoU0IV8InEpFHwTOsOYh17YwH5X0PN3noLyK+J+EUuENP4SY3Wz5yhPmaI2KVbtXH8dB1sYiSMmC4l7dtsc0oeAiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746752216;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=A9fD9J9apXXQWG+5+9SE/Apct0XueoWmTBctWd7fEhM=;
	b=IQkwAE5d4AHmN4FAa2CRCrUABvio0T1Vwu0HskZXpF9KvBptzRh71ebVTuIhlPeI
	3QpDjE7IxqOMJ3Vmfm+GzUUoMfbaINv4RYufTnhYiNnnmkqhX83ifYwMOLA2rKNcMCo
	tySI/gX97YiCiBPakNz2QrxPq8KcNc8LVsafqoxg=
Received: by mx.zohomail.com with SMTPS id 1746752207806145.1320237524577;
	Thu, 8 May 2025 17:56:47 -0700 (PDT)
Message-ID: <932e786b-3c34-4753-8b56-31b6c0f1df41@zohomail.com>
Date: Fri, 9 May 2025 08:56:44 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] cxl: Remove adding of port_num via
 devm_cxl_add_dport()
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, linux-cxl@vger.kernel.org
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-5-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250507004310.3536991-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227dd015a73f3de6b2ade26a99c0000512961f3316b35ff22b8116f68195cf33b62e67b61a429bbb1:zu080112272964211a29f98ba285c571100000b079e8c9d9bd752a73ea966bea73bd98a49c320e0d85c5668e:rf0801122d434d9f1330eb6c87c3fa684400007b0fedff214287fe4464470e0efe079bdda0d463ffe21c5d3e8c69eccfca91:ZohoMail
X-ZohoMailClient: External

On 5/7/2025 8:43 AM, Dave Jiang wrote:
> In preparation for delayed dport probing, remove setting of port_num
> through devm_cxl_add_dport(). Will temporarily set the port_num after
> dport is added for now.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
