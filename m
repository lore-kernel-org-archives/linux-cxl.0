Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0D2EFD8C;
	Tue, 17 Jun 2025 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192404; cv=none; b=E71oOQJzEfe1mD1Y/TwPcPtA3dQmOFU0c/pm1uFaUHjkgzLZJJzgV1TPDX6KNfPpQMW12jftrSE6TFruieO4YgVjlU8Hf7zYCxRoH1Bqv5/qS/CgJA/l4bQ6ploxyNOOtCYJeRWKLXbRR7QzQpSXeW4/1iq56g7D7va7bOqgT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192404; c=relaxed/simple;
	bh=m4Iw7odXBvaU5NhYgp5hg7BYI4mtkDYlgIUb/0y1/eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utsCcngy8IIqo9LvI+YtQHU8GKpedGqKRIVwmpby0HEyaYyDapFothO0FKWWmn5l9m5bVcD4lY8I85H46yRZPBLt3rALcHnwmDqr/eNmjzbz2MeeXHUtsdxYp69VDEY1e9PE2IXvDqYtG7VejfyOlB4AoTUrGi03130fQacIcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJU8smtn; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJU8smtn"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7387d4a336so5299358276.2;
        Tue, 17 Jun 2025 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750192402; x=1750797202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgLoQ6crTT76lXOGCSJP/UyWl0Y3WfZNh5XaX/5vgKU=;
        b=fJU8smtnLAdoOLRQajGYrhhfp64ACDeps7edPFUrUFXknkWxexi/Cyh3kQbdTqKWd7
         J0nvLOKIA0TOU08SQOrjwS/fAz7O5gd6Ka0xp2S7wgCl6SLjq7jurUqraTvK51o5LEEC
         tAYrUQQYiWJvLfj16LSftpEPxI9x75VFQ9GrKzjNOaBoqi0AC4IYl6q+6eLNz6d5toO5
         FDLBuRAhRRlb9NnQEC+2fIatJatvBdqahRnS6Hqmgu1C83oN4tSt8qv/ZJyVtwrIoLeg
         /1SnIAtJTKO9kz//2H9uGq261INcbURkV9N8+fDYmgMs/5+2Pj850fRdzdcsdccYFPEr
         r1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750192402; x=1750797202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgLoQ6crTT76lXOGCSJP/UyWl0Y3WfZNh5XaX/5vgKU=;
        b=K3fn+swLKAaAmtfO3/DNXgd/N+Lin8a8gZb22wiUGaCBqFa0c1M+c2f7MucmEiPuAF
         1Klm8TxYJCIljZ/MxHDsKCA2Wtb9du8KhBfZok701IojsbgOBg1iAvE6ZDTVLeKVAFy8
         uwsEfwwLFxWckOkqhzwcuiFhdLxs4RbUp2rsMNmkoPEIfHqxRFX/f/PTFa0XfE3dbahA
         y1oGVs2J6jcCCoZ4IIQ9mJrPmFkT3n5iXzK+dsc79jFItrdn6XXPAP9+NNsnD+Ymejwo
         3eeUdJlBAu9GnNBPYG+LiHuvRECC5gZMrINozXo9oC+Hgx7EdAZLjxCs82y3QerKSmIV
         hknQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMLFauE0Sg2VnAfowf99WOcg3YUB+7QJ1GVMdDqsm8SvZPGFun06lTeWPnRaNyH0AJACFxxzzLaQakaF8/@vger.kernel.org, AJvYcCX27icFWNjdnhZEIzJG9CfOrxo77Lxa9wK8NFH7DQUJ0aRw0hIgUzGrTJ3xFqIT1VOfhY0dRU3px8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mvF4g11LhCW64VWMfMcXxotI4agVfA7kqQ0VUOj3IOduxepo
	RIBW9L4rAxqdyijKZaoAgeUhKh1L7Wz1kteWu03BFqQSBmPSWLQPV157
X-Gm-Gg: ASbGnctxfp8Xh99toOxuzghRU1DNvf25A0wCH9IV+vR7TsD/d4sgV3HExRt/aaVJTbW
	P5xQ9y3SStMappO8HW0b24ENkx82gmuEntgcjEKA5j25drvKFB+FOJKEJu0HsTjTtWTy2sOw52G
	GADfKRpNRbdE/c9xPxWwbzcOicibMM1J4D5SKvSWPcVhfOHNouS9Tpn/eUw41E+kFx4bTwwHYBm
	LuegWo593PgL04+nGMOZUwZ/m4zLTdl+vAqKzBJgou5pMISBpCRl0MqXP584yekMhy2czCUp60k
	P1uHd6s1AfkcoSLvyeYalkUexCVpZQR1QSyNEvC7A9nOtkGbSk2M++jku+Gg2g==
X-Google-Smtp-Source: AGHT+IF4aCgWzzElVpwcBxwysKSGd2rmi3eJJOOMWNk1eC0qay4rNw1WoWP5TiayvNS1VGCs9tKV9A==
X-Received: by 2002:a05:6902:18cb:b0:e81:f8cf:77d1 with SMTP id 3f1490d57ef6-e822acb2e0fmr19569399276.43.1750192401682;
        Tue, 17 Jun 2025 13:33:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8251aba27asm1603749276.12.2025.06.17.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:33:21 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Robert Richter <rrichter@amd.com>
Cc: Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH] [HACK] drop zen5_init checks due to segfault
Date: Tue, 17 Jun 2025 13:33:18 -0700
Message-ID: <20250617203320.1760101-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aCO1TGvrXajf1s4_@rric.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 23:10:36 +0200 Robert Richter <rrichter@amd.com> wrote:

> On 04.04.25 22:38:58, Gregory Price wrote:
> > Unclear why this is occuring, but a raw call to the PRM at this point
> > causes segfaults on my Zen5 system.  Later calls to the prm work just
> > fine, and modifying the structure to include pci_dev info still results
> > in a segfault.
> > 
> > Debugging this is not possible on my end since the crash happens deep in
> > the ACPI prm code.  Seems maybe the PRM interface isn't ready or something?
> 
> There is a subsys_initcall order dependency if driver is builtin:
> 
> subsys_initcall(cxl_acpi_init);
> subsys_initcall(efisubsys_init);
> 
> A fix using subsys_initcall_sync(cxl_acpi_init) solves the issue.
> 
> efi_rts_wq workqueue is used by cxl_acpi_init() before its allocation
> in efisubsys_init(). I will address that in the next submission.
> 
> Thanks for looking into this.
> 
> -Robert
> 

Hello Robert,

I hope you are doing well! Sorry for reviving an old thread. I'm currently
trying to apply this patchset, and saw the same issue that Gregory was having.
Keeping the PRM checks would be helpful for debugging when things go wrong, so
I wanted to try and apply your suggestion, but had a bit of trouble
understanding what the core of the problem was.

I was hoping for some help in understanding your explanation here -- I don't
think I can see where the dependency appears. (In particular, I'm having
trouble understanding where the efi_rts_wq dependnecy matters during the
cxl_zen5_init function). 

Thank you for this patchset, and for your help!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)
