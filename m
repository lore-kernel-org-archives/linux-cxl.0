Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C824339A
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169699; cv=pass; b=uZHCji2/QLycFAdbwJCUWHJsbOI0teAj6l5y5QLCe5cZB1BkrY9dhgoopSKK6l23hWRQCRxVWo0+Y9r8Y+VRCCCUP4ZJyuPZdONzWfKeVcK5IEIDKB31rIO/jC/5P4O1AUyfgmjm2rUcJNelZvlyWfFQN8r2tAFCmAsMvE53QRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169699; c=relaxed/simple;
	bh=XEtR9vK4GqhPOOdjSgu1vJ7QuJXNnNoM+PViLlOU5D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTNbGCXYqYpD56FKqBVzD3O+KG8fwzvDGmN7Dm3V9UhNFdUVGgDnKDaxMefChOlG5ihRl29TAqBXxNivxmfUxWvppW1rkn92S+u38ifDcr79r/2O5+GANP0Qc8+z/qbAfz90a0qAUHZ/mjjqRJwcgnDSIVOT+1PoOoZ2UEad29M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CnpJpPT0; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CnpJpPT0"
ARC-Seal: i=1; a=rsa-sha256; t=1739169682; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QIZmlRvlzTmRTLzlqS0RC7lRd/hI5+FJAP7FgLuWdlU4ndkTJqNsmgGaHAAKXfsAAHHGcFv1mo0SJf3lYMtKQ6PorgapmDWV/VxnFxCTjAxMFDp2iehnKaee0nCmzJc2b4jTm5HkYYDkgL/q1KQvVhSfJ4WMHWBgOVj5pEx3bB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739169682; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XEtR9vK4GqhPOOdjSgu1vJ7QuJXNnNoM+PViLlOU5D4=; 
	b=cHLdnNSmJxeyAYtdvrD3aojfgsC7W2qUsl9Po6O9IOqhJXBE0LDRNd8GEFakshkqeSYNAE8wakdqjBZ2DjhdTQ5iTd1+0VWPOKxTQoX6mtq1h4vR0ZfUrT3N0gHuQc7ELjD2agv8XwTdr5lUeMIMuWwKrSwaZQ8XkjYnrNVu5M0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739169682;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=XEtR9vK4GqhPOOdjSgu1vJ7QuJXNnNoM+PViLlOU5D4=;
	b=CnpJpPT0HB7GNwbDXTxK9hXIWEB9X7gG47PxsW1fd7eTjtPnBWvF3uLfKYz0/jLZ
	Ul1WLGGVberbk9cRKJZscg7OH5tQEOLvG+6mpE8xJ64TSf5vr9PidXXUpsllOE4iL5k
	j2TcCR6rYnbs93gX7x5EjsHN7OpA/zDsx5vD2ykE=
Received: by mx.zohomail.com with SMTPS id 1739169678392948.10736945649;
	Sun, 9 Feb 2025 22:41:18 -0800 (PST)
Message-ID: <d79c97ae-2fff-425d-8bc7-4a898189e1e1@zohomail.com>
Date: Mon, 10 Feb 2025 14:41:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] cxl: Add support to handle user feature commands
 for get feature
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, linux-cxl@vger.kernel.org
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-12-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-12-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227f131b09e5f0cd9e9b845b7340000670017dbab3303c19799b6640086636a2148b0913eca81e7ca:zu0801122715fd797e3495f3e5bf1ed7d800007a51c80f729c46ebdbcc10f50478c2a325c6fd4d6be0f623d7:rf0801122db5c90e57a7acbafe028109bb0000d789ff4243271ffd0501f762b458a9b211b300daeea1bc710f28fc80bcbfc0:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_get_feature() call.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>

