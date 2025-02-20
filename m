Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AFF524F
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029542; cv=pass; b=mautYGaqcWIq3s28/xtojTyduAZh0bzJ3VCAB9eE7JBNxOFpW1GXu7c6CA6FYh5F7PI7gfLhaVO++cqtVks+ynKK1j+8RDiXfsAxCruWkk0Ipv5HMeDzFsswkhtyy8EUGidAfBX0n9Q6khvRLWzqAVf4CFVwbJEijv0Ab4Py3pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029542; c=relaxed/simple;
	bh=Q5n1Pa6BqOeLR8l1VxvS/7IzbpwY10Mj1VR93fQ1m84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiJgJnGpvBKWh0yrIoqmggqMozFpnqcLOhXXqVI0sQANBGkswi2iVHKfT8TKKNpfRGA0swltQLp3ex/ziSL/G9L73wELYIxl0a1Vrzowwo2DH7XHdsfp8ISSe9LZbkzN5yOmXxCtzHYQTcc95EhsHQ7FJRCNXX8iB5Jj/IirN8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aOvwIyn4; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aOvwIyn4"
ARC-Seal: i=1; a=rsa-sha256; t=1740029521; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m6TU+6I9pREgfMJZGj3t0BfSVVN7QkXB8WGGG6McOIie6Y76MsQJ+IOxfHoQ0sUb9mwNwSYm5kj2D1PHqF/RyRjT7v7mrMJyjKohha4MuL+n8SELJ0fn+BZASbTPsvy26w6X9DvAqH+QHK0w/1dEOa56bq0OVV7BVpYwE2qLNeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740029521; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q5n1Pa6BqOeLR8l1VxvS/7IzbpwY10Mj1VR93fQ1m84=; 
	b=ONcA1Cjb5w06zRJudMRZAy+aI0BX3P6Mq7P+S8ENW6Juk1fbtJ2kwuqvcmpeAhRPMmi1DJ+CIydZz/0J4bjvUDbwCwadvj5BTkySlUwo4jbXi0/51lGvTn3EhcNAZClOTheVRIa+A8qq1ZYSiQob35AgTEqXngGJbMhp0pyvTng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740029521;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Q5n1Pa6BqOeLR8l1VxvS/7IzbpwY10Mj1VR93fQ1m84=;
	b=aOvwIyn4yRg5RU7zM4JMcL+jD0DLsCpp0em95mtxyZ8HfKBP4tnBfyObIbD9tGv4
	W4Gt26n6UCQskmHIOjzEUIyhfMtgwP7x2Cdmr327NjvbMbvkt/sefd/O+9J8sfiHu7T
	96I8K9qlfZ2LycZKi2/FIw94Q+XXBl2yHfFUPp38=
Received: by mx.zohomail.com with SMTPS id 1740029519018459.6346948555505;
	Wed, 19 Feb 2025 21:31:59 -0800 (PST)
Message-ID: <51178169-2d6a-4341-9c95-9382eb50cbf3@zohomail.com>
Date: Thu, 20 Feb 2025 13:31:56 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl: Document missing sysfs files
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 ira.weiny@intel.com, alison.schofield@intel.com, linux-cxl@vger.kernel.org,
 dave.jiang@intel.com
References: <20250218224853.67457-1-dave@stgolabs.net>
 <20250218224853.67457-3-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250218224853.67457-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122785d13175063ca50a1d6a469900006581ce30bac8b8a8bca65ee7a7ab331a7cb2c84950178f4bde:zu080112274a178d433c0a64aba998a6860000f4a6de651ddca0d1d83b7310a0398436ec3551960e3cde00f3:rf0801122dac73fe5cd36dd08d74a0631e00004b607c0d3276746c0fc8ec1db72e48bf261d1b4fc61ce31e29d383d5e3dae0:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 6:48 AM, Davidlohr Bueso wrote:
> Add to the ABI documentation the payload_max and label_storage_size
> read-only files, which have been there since the early days.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>
