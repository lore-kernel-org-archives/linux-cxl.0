Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE27346F
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377683; cv=none; b=MqNGZPKcuBgLfo9gE7sUjz/q6KUQhl1E4TNcjPILTAYW96yky3xzt12dG6BdCBX/vcEBH2YTRCGri1TxTepcrXBwnVqsevEe7Mgtg+26pp+H17HhnhFGLNeQx5HI8LzTLGxpWmq1o/itojul7toeXiAumTZu9ycoBRb5IgKZin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377683; c=relaxed/simple;
	bh=DBVgDdif6yxRg+snp0WJEq1J1tjrHAlyP2uDA8cpPRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn4cPOrKLY8i/0sXutxS2qdDSgU2dLYZxpUNDv06VcbIokkx9iyR41fmLWUyox4XdSiREc6IKuEnXCmU1TrB9gcGktVpYsBmG5svoXkiHc11M1HwPAKtErvJb4ERib1E0LKBamePYBrikPL4wsp77XQCi14cgV0xYzK70A/uzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jjur+hcL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jjur+hcL"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c08f9d0ef3so141705585a.2
        for <linux-cxl@vger.kernel.org>; Fri, 07 Mar 2025 12:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741377680; x=1741982480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvEuekTxOytRYuPmu7QBv1qKPH0J2Un5a/QcUV2hplY=;
        b=Jjur+hcLIvrC8m3JMaNst4r0w72yyBSzgibuan3nZ6Zq/xpmZVORyVPTBO5Cz1RVhf
         C8OcvDHyy1eW7ROtYilfgOdS7LB+Jhub/zO9bKMddDlgQpQzH4Y6CuNEiz5xfYSkyAG3
         5xmH/g6VJfJLhxsBV0dsSTpJ1JPNXRvLUULXNc8T+noxrA24yj+G53mdt3R7MTvLF/F4
         bvbUL81PD2m7kLwnTYZiHtZznUv4ONOvmCfsTwHs1OjF/dCrxcpW+9EaAWb4TLozizQc
         82LqXuLjJO+PQ2fc7fLu8cAdta+iuP0OCImB56/TafUuhnWFt00SCJFFIXHVpabupFG4
         k5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741377680; x=1741982480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvEuekTxOytRYuPmu7QBv1qKPH0J2Un5a/QcUV2hplY=;
        b=S1M1HsFeDtRlfWI4/akWWltbr2UK8ksyTXfcyQPO8ocPzD8S1Kn7qC1stfoNAbjuL+
         ug+GY4+II8J0TeNJ3lKCt7f41J9AZf7elAEm8JbfJhCNe3veMggv0Q5JlN39dhuyWXVv
         GbrPTP+jeXn2JhE+GSBItM+3tORKp3nuhmLk7Ccq8XxTXYb3X/51RR4kMvPLR4RDBRzB
         BDnJ9I4FZyt/yOQvtlDKnByieWISfYnk+BgUQXt4dqWXm7k6mraxdjNVzrhP6XjnYJAm
         S2m3osfTzpN5XwB8h4eVFNW4yGKa5ei4GzyJ69I0NAlspUaYxKnC6EjJFrkywLh+Rk8Z
         ClXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqs4iBjNmVk5E0q2sa9RuHjYbGQOboo2iJZu7Mt0ERQFieedH7fcE5Fc54cw4koNuLLRSZvs9EoZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwliTkebBovRnadCPr+nuI3G59MEzv8AallV/RcxJ9QFqMveGRb
	5oSKm1uKYyMt+laviAW3mEfJUUBd1HLa7SKcrsksrZi4zn29R+WD5nenrAwj+zk=
X-Gm-Gg: ASbGnct2bgk0UdHRWjaYSyVYWwE7NIfkWqEgzaSP8idiu6293lz4s/WmqddT+7pwX4v
	qdvQE/zsvf7egz2a5s9E5u+g4gqsChRJnCRTP/q+6sLmb7q5Nxnat1Qu79UNtWfB3n8O5pFI6IZ
	s5VV9fbjUTe1qLk5p7UgRQG4XI6L8nCU6sg0+m7u1HEKydGDTP5zYdvhb6goyX/l05S+3G0WWlo
	6cHTsog+QAa2ki8tUvVPHaDO5w/MKolQI/MhFmHk0bqaKUeONW8kV1sSYsi2MvLgrmRAgfM6tXa
	Ub/kjjeag7EY2OrlIHf8oCdZiJ1zC1+JbS3MlW2cSjjN6QrKbD5Qzlw4tyavegdUG4NKjcBaIH6
	QVByJYc7VVoKpgqjzOIVOIRUmPhw=
X-Google-Smtp-Source: AGHT+IEtnZaQvm8ewVuq2G9dOb9koQirc0O2ZB9U6pXE4Ihad86+Bm+bVLhCRd2TqcDPzF2YM6W+KA==
X-Received: by 2002:a05:6214:2464:b0:6e8:9a55:824f with SMTP id 6a1803df08f44-6e900601223mr47549496d6.6.1741377680514;
        Fri, 07 Mar 2025 12:01:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71709aesm22793246d6.116.2025.03.07.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 12:01:20 -0800 (PST)
Date: Fri, 7 Mar 2025 15:01:18 -0500
From: Gregory Price <gourry@gourry.net>
To: alison.schofield@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Restore opcode order in enum cxl_opcode
Message-ID: <Z8tQjmjseVgEyFCd@gourry-fedora-PF4VCD3F>
References: <20250307181214.2624147-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307181214.2624147-1-alison.schofield@intel.com>

On Fri, Mar 07, 2025 at 10:12:10AM -0800, alison.schofield@intel.com wrote:
>  	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
>  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
> -	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> -	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> -	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> @@ -551,6 +548,9 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  

[04, 05, 45] seems like the right ordering for an enum, is this
based on spec ordering?

~Gregory
