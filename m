Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69378155A25
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673219; cv=none; b=OLLDov4nNwdpavZpRQIol2yjBQdtDo0lQ2+bXw1XSV+VzYNXLDYzrczNYqvIgKvZ2bXMFAlM7TgVQ6ZutScgciGxwKvbpnvn7byzC1MLxwEFcDVGAb8q82Vy/as69rDUVzTFaQHwFMqRjdEig/meo8tkQXcTcUvr5I/34hkiUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673219; c=relaxed/simple;
	bh=BfEx/DGTy+etwnx3QSf/LLwJ7pTvHjuchkhtlgk5UK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GJzZp2BBshkXbvozOeLAxW8aumabg7yAolbNCZ/HpYg0G5miZJLpP2RO7goG4TvGfcF5NIYqL9R5qc6wA9+CxTeRRKvDsm5HAma6/NsQ2+AARjocGFxgo7yFGRBI0btbAR4uq3k6rEPEOnRzCBiu2NWQKYmpBmy8Avs2Rbrbdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBA6G3qd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBA6G3qd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729673217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfEx/DGTy+etwnx3QSf/LLwJ7pTvHjuchkhtlgk5UK4=;
	b=eBA6G3qdAOMzrlAS4OqX6g9ZIRXDo+EjM6n4Z1chAqK/dpvlOrhK0x4AEDdFUinBZNM1FG
	m3ldCA+jlaB3UrayepW5TWIkor2Tp7L2sE2UumkPMNhNe6YE8t2HIVGZEVKQ/HZ/LN/BKR
	1C8sNj7yvszLsIP1aWzZ7yj6Ei57298=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-EZqxVp6FM-iTt6k6lZGT_Q-1; Wed, 23 Oct 2024 04:46:56 -0400
X-MC-Unique: EZqxVp6FM-iTt6k6lZGT_Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so3678132f8f.1
        for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 01:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729673215; x=1730278015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfEx/DGTy+etwnx3QSf/LLwJ7pTvHjuchkhtlgk5UK4=;
        b=m/+koH7b5+1QMwkkAeLFrN1HcGojTDxNlbnxCr/tnWPy1aUWSmaXwxmv4tCGzrDAbN
         I9Fp7ku+MlBJLJJxkWLsVVEwR2hYlr8s77W16s1kIfSB8lJHxZeBLjfIEVz2JU/6H4Ra
         RkYCcgD1GaEuotRyduwG30zAi6vAFHe7QHcVaaFGFkLvMhK8jq/bXzpYHws2sHHOuDQZ
         D7Ie3QrQf1qOVLTbpmhKm6ozJBoOvoADcj/yAYViHX74E48RARsQeOTxBCcTpJqN/n3X
         YUesGi5n3jqrr8itoopn+bKA1fk5Y1DltWcTQ4RD3i/1l/ZgMXKDbH3Mvp4AoSOq+ntF
         1Pqg==
X-Forwarded-Encrypted: i=1; AJvYcCVoY3bWpHxU8KFOy3rHtWIAFZwCWWucq+Zjs+bS7QHM0/eJishp6413JXjrJHaw4t0M/ZWmBdeSeg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfsF9THshI6RGnqwqULA0ccgdwFJZl6cNgKAze0VTZk25Gqyz
	ph7aV1PoapaAFV1y7eEWCBxT0Bh/JLuWdngVPmgay34kSP1aGKT2VpAoIkBLe5mu3xapQwkdRKo
	oWGw5J5USXXws2uFWon8nJgVRzEogGiBEeEeNG/aDhrWHoWuIKe0uXbWjfQ==
X-Received: by 2002:a05:6000:18a9:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37efcf1fc01mr1135687f8f.25.1729673215096;
        Wed, 23 Oct 2024 01:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1SYY6CyLekUwxKlnFZKNXUKAAfEqXFWJcII0J+uNLboSCz2hbmrGghitkgxAUMr8DsnJ2jw==
X-Received: by 2002:a05:6000:18a9:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37efcf1fc01mr1135673f8f.25.1729673214688;
        Wed, 23 Oct 2024 01:46:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8455810f8f.73.2024.10.23.01.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 01:46:54 -0700 (PDT)
Message-ID: <fb2d7565-b895-4109-b027-92275e086268@redhat.com>
Date: Wed, 23 Oct 2024 10:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/26] cxl: add Type2 device support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

10/17/24 18:51, alejandro.lucero-palau@amd.com wrote:
> 2) The driver for using the added functionality is not a test driver but a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
> buffers instead of regions inside PCIe BARs.

I'm sorry for the late feedback, but which is the merge plan here?

The series spawns across 2 different subsystems and could cause conflicts.

Could the network device change be separated and send (to netdev) after
the clx ones land into Linus' tree?

Thanks,

Paolo

