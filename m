Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542D221FAA
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911895; cv=pass; b=IB5axpCLVztuSQPGJCuNc23+wiIXB6GoloB6jOb4H7vXUUbB1vkdJ+o6hKVAN5WWSs9PR/p2W1baCvaFw4ExnMalgz/b8FvsfeE6oxAZ6HgmgLSLIEcNJ17+t5JCuIUBKksegpBnMrBa4VLxqNaaLn1gSMePTmRU8i1RrHg2nkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911895; c=relaxed/simple;
	bh=Y3q7RQi7mno2use9EvDPF3UJb/UXc5DJI3ecq3RW4l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+zPIprrDjUheZBTHneLdF7bcJ5RoqATsdm6DYQCP51OQ4QJnWnTFSvDHNzmzIbSMyIFpX6DXI/yYJ768BwaWaAWgWw0U376q7Opn+vEhiAh33kbQnJ2VLyvYVJOfF3squu/uuYXk6CHaS/fm1dC+xUzjwQOWY0D+FTHVDZaeVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Xw+qmzYb; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Xw+qmzYb"
ARC-Seal: i=1; a=rsa-sha256; t=1747911880; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BBl05GkgOPK1PMnQdLJpBkKB25aIaMvhET44Rq6BIuK6+KDZ8J/dAYltNuPihUZejdVw8mj7i0jKPFGaIPMFliAfFaKyHSG3h+taS3VDeESY/dBo/fycW/jI6EyUVpE17Z77Oz+Xi6FlkPeJvkmpdzoqPnOdqgpjCzf4BIEuC4M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747911880; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y3q7RQi7mno2use9EvDPF3UJb/UXc5DJI3ecq3RW4l8=; 
	b=BJNYRamiQM/ciaFEABe/KcCg1/PoAjzpuI9QuKJLONLsc2NoeJgjCQbwn5Vg3cmRO93KKwrd4eUdZunMDe9wPNbPiwnklkiK8J0R2qJdOjU+dCNLyvfsdcQbEcFqYVEZnurJmxJSwyzzyMqYIyBynVo+Rx6qAc3H0Bzb0HNqNJs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747911880;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Y3q7RQi7mno2use9EvDPF3UJb/UXc5DJI3ecq3RW4l8=;
	b=Xw+qmzYb1qjwLsBTGnm4fs8FQnTHYu5kk4qvkSIkeA0ZLZYaRrnCoxQ+XDT4vrNS
	bgtQSuTmJSi/CYdr6diaWN8NexEC0GQ4MHm4uCSLnMV8EQNzAQ0LacVBa3m3EiiJjGS
	S38Aurqk7nZ+fWTcCvkAfmTHvMOuTPRCrbAFWh2w=
Received: by mx.zohomail.com with SMTPS id 1747911878863670.5709260300591;
	Thu, 22 May 2025 04:04:38 -0700 (PDT)
Message-ID: <0d2f40ae-07b6-434b-8943-eb0cad278123@zohomail.com>
Date: Thu, 22 May 2025 19:04:36 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] cxl: Change sslbis handler to only handle single
 dport
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Gregory Price <gourry@gourry.net>,
 linux-cxl@vger.kernel.org
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <20250521183443.3828320-8-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250521183443.3828320-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112279f019f8443585b02e6defbbc0000a3b30d2d78e445e240690d9443c2f561588c2a6fd4478b4d00:zu080112275db273d6359f743f57c52a9200001c25032b9c45dcd9a0af185a0ef2689a9e0b56ace52a6ad617:rf0801122db2c3245e87e8ac52a76275870000757d176faec63ec2e4e3d7cb4ee45ff76de436157f7f8d66932412571d8fa7:ZohoMail
X-ZohoMailClient: External

On 5/22/2025 2:34 AM, Dave Jiang wrote:
> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
> not efficient in the current scheme where one dport is being updated at
> a time by the memdev probe path. Change the input parameter to the
> specific dport being updated to pick up the SSLBIS information for just
> that dport.
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
