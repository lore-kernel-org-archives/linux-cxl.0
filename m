Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA7172BD5
	for <linux-cxl@vger.kernel.org>; Tue,  1 Apr 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521184; cv=none; b=sQ/5tesd0UMvv8HHmJMMPyW6M5pqV7S8/F3psGAG5qu6qLXKr9VEAfLBBlD8kGWLO2rB8nPrWRLGUxRFujcXYizf+ywyOkLLs45rCjyuCH89BdzYU0SM5hzvsLLFPKvLMiPyzv5GP2rgikyawZ7KTTcKbT2MOpvUtwKyRNjBf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521184; c=relaxed/simple;
	bh=vFboLmEFuu02I4h6m3CmT8LvPhmuOPFsnUOV3jftNu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxPpTMQQjkgV3bIquMb5H/+1XyNsFK3o0zyV+1PN8vo/oQ3LVSeTo4fdS2iUBKdE+gp5hk0zcPF5pgz1YwsoP57LjIKMDQi6/RkSpmpvNR2Hma1pli9RL9VwI1KCDQSjxJjAVAdR1lBhZ2gaX3lm0GmjX7fdH25pyQ7X4WH59Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GWx/HR9o; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GWx/HR9o"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47664364628so60921021cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743521181; x=1744125981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCIQqA4ZGzk9QkSYxmyLd6ZmAQH4PEoYwFtk60P0jAg=;
        b=GWx/HR9ojKMYBQWNss7Y4BIuDJ04xzYRPKXRa4jSyDtE1uY3x/x+snHSDUIDjrFyzy
         2+ogIvbhZu00dP6anm03R2LaCUb3ZJV3jPyIBv/PpGDcUtTaQSmmWjquV0P/fOXPtjec
         4ecdrLzeuzy7geHBfknjCbo6xPlY03I/diuN0lKp5fuHZRVXxdRuAYGK4ypF58hIpWGg
         7WaMMsJpDwAEP22iFkFuYqP9kbAereIdNbnwjPwzgZu9LDMB3p+S6oiPKumpqGtQecfV
         vrfpsd4xzRckmU4Y+qDbN314zCgT7x+o1SF9zZ5VFuNBETBWTBwllqGmjk3qED79pY0v
         b/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743521181; x=1744125981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCIQqA4ZGzk9QkSYxmyLd6ZmAQH4PEoYwFtk60P0jAg=;
        b=QPDigSiKb7tcgHeDmvpIWMrWsfLDl6gi2CRzYZKfDiUjmnwiJBnk1cLZwD11phnyU8
         Zh6J4nJvKo+P/edL0NJa/vNDZg47LKTVwxFmUjbFoTiNTxFPiF8Cfoykt7i4LXMkNrLn
         8FL1ItCR/MZz/XPYmhGhDGK8a9T9+ofQmmPj36aFXGfir97tdtrJoThg2Gp7DHcxVKwU
         koLxj4lBD5jiK+w3seSUbfNx5gA0gEJTN+mtsPn7gXqcAmaramjKQDOJJBOLuMQROXhm
         ljGDvBlgx5S6Nj5HZnvNwQiGvevyZIGYJ0wWs3q08ZtRwL0Py8iTmPhFoydfsb6gPiN9
         s6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWfwkuSSpoAH52DbiElzPR7CxZOCF8V0yjX4HnSh8OvrdxE/kVE0eHqGdIZSZxScFsXS1QJ8yQTElQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygdHGKlfYDKXtTSUJeZjEYLg24G39AQm8qj0CP4yrze/vAzi/f
	//cJk1/3x8zmoELBm8ybftGbndn7zj7liNJJbkJyCv6Uqlq2+UqAOwhtpsiQ40I=
X-Gm-Gg: ASbGnct41mQgzeMn5yVsGzaaoQgycWPE7dnpZSdPGrI/6SjQuG+Mf0DgmocRgDeDuHi
	2SHkjPBXFBVEjcurIQ758yiLLVNm+GBKErb+/0Ak7eIEylT58ospi6hGg+WcjHDQjla23B7brG8
	jai8V4IgNVK7kJoc2sGxmDVrsG5hqLJzz9WM3sX6UX0JCz70X4i7gAGzb0JZMdjdCYoslMmzDIW
	VYFwVf1TNZGOeYS9WL4abjpA1iy6KszRAk2Gy/qqO1BYRwY4zS0EbxrpNgwWgwfd/YD8QIipV2i
	rrid1v93UnzEuisTf1Nztr8o6kOAMmRa3x8FoXJTxjzHaFKo50JyPsa/rncRdlBJZ2/8Ba6L+1U
	hp8Sn8k3/VpySVg193K/I1i/RrQU=
X-Google-Smtp-Source: AGHT+IHzkThr7Aq5f4/8WZu6xqfIvqH1zUuQXxKYJ4v0IT0w+E6rcLFyC2loEB95SdAcliC5w56vtg==
X-Received: by 2002:ac8:57cd:0:b0:474:f1ef:3a54 with SMTP id d75a77b69052e-479039b2455mr4837241cf.9.1743521181535;
        Tue, 01 Apr 2025 08:26:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a7aad7sm66913571cf.35.2025.04.01.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:26:21 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:26:19 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: dan.j.williams@intel.com, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] DAX: warn when kmem regions are truncated for memory
 block alignment.
Message-ID: <Z-wFm_zwDZy6jvVz@gourry-fedora-PF4VCD3F>
References: <20250321180731.568460-1-gourry@gourry.net>
 <Z-remBNWEej6KX3-@gourry-fedora-PF4VCD3F>
 <3e3115c0-c3a2-4ec2-8aea-ee1b40057dd6@redhat.com>
 <Z-v7mMZcP1JPIuj4@gourry-fedora-PF4VCD3F>
 <4d051167-9419-43fe-ab80-701c3f46b19f@redhat.com>
 <Z-wDa2aLDKQeetuG@gourry-fedora-PF4VCD3F>
 <a65fd672-6864-433c-8c82-276cb34636f9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65fd672-6864-433c-8c82-276cb34636f9@redhat.com>

On Tue, Apr 01, 2025 at 05:19:28PM +0200, David Hildenbrand wrote:
> 
> Yes, it's valuable I think. But should it be a warning or rather an info?
> 

dev_warn, but yeah I think so?  A user expects to get their memory in
full, that means we're slightly misbehaving.  I'm fine with either.

~Gregory
