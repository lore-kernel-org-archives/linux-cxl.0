Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D4605C7
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848482; cv=none; b=dVF6JNtnKHsP55N4yj4EZG1d+ji+bF3DBF3l6VJ5AU6DawkuWjd4x+qAKtrGXriDL168XfJrkHskgCaH76yztNaUfnBA5JbYe06te8hLC+IiduNITWdCAWpLC5LMo2ZpFi8Vee6ravCnJhbXB6gWN2rF31F1NHnpUR/hWV0NOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848482; c=relaxed/simple;
	bh=gVrM4Lf0jBYH+ha09mLVPY8cuFIb0jyYslplNAZnogc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEScCLuK25qideE0e+VJ88draDzZmN8m7ld7aPo2tw8krf0+/aQ/fCe7bl2Cc1qPOckI6x59SEtlt/ub4TORvv27YdysltIBzAgF3Is8gdKy0uZ9XSCPrPmoNqUpDLumfl22V38fFZvwBEQ4y8Qz9/PCYmA+uQZ7yn0WRv1Dvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8+fP+lP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8+fP+lP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29080973530so3378778a91.1
        for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848480; x=1708453280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iID+5qHzUzwG5TgDFukz1qiwGtm2X/wRZ/SBXmMx4Kc=;
        b=g8+fP+lPa8XYm77yB8I3BGvy9x8dvWQLcQC7+intX/hRS+6bQXK0alIpMgoL75+6FG
         dPO9H1qohU3wefIjYlJ+F0Ao+sXFVXlyOib4uQ/Fe2ArGm+ziEtjw750Q0Z55ftOOUX9
         S2vkD2UJjzNPISb4HIVisqcuQR4LGbX6TVHtEbfAKzqL7O/jlELwwHEdHZeQZt2Ia4lq
         kApWJzEa5wK2y3Oi5JbDJRud7WeVoQnOnGCfg9RbwhCexAUR7Q0acSyeBBe7vcM2X2ei
         mvPLHpW1bcit6OSP7C0woFCixvfB/OoizLYNmcQ41Xe0jgxglbozQf7aaFwH3a0v/1Lj
         VU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848480; x=1708453280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iID+5qHzUzwG5TgDFukz1qiwGtm2X/wRZ/SBXmMx4Kc=;
        b=hIK/Gyv4djf1v5pZlfBhUHV7IOOYTGQOZ6pbBnMX8Ucqav/XuavxP7CQO3F+tTFJBp
         3gK1vqSqxb7DNTTK0RUGOl5wDYquV/7Fc7JD5Y93Hhk2TP6upec9l1nenjusZrl1DcQb
         yDust0mo7+sgr2A+2Lh4TyiODgD/pjzfQk71eefaxB1nnDlha/QWnwMg9q2gxy9KyyOh
         KPqRnSRYA+U2+C1eZjNIPRUH0N1b6VhBilC5rb6cJ97OI05cUS8EbEpAwToy6M8Mj2Ot
         3oeWwOYvrsJH6K3kV+5m44OBEdE8ybEo+jcQ4YlneIX8r5tly6wnvt/yYBxePZOs9mQ8
         twXg==
X-Forwarded-Encrypted: i=1; AJvYcCWqvuSdYAUD38tcE42cgzm0zva2eqX2Qstp8OzVrwJitECQIAXx+KWFvqv8F6fPzVxpvZndutppWNPN7UJ2j2up6WWawcOeFrAl
X-Gm-Message-State: AOJu0Yyet5epVuLok11Ju2Los7xCh/cdsj4+tJdwL46LIM6L2+NU/7mh
	ozlMOIESpIlwN5axAyJFVHrKkaQMUrzqyvY/iPHKeQ9HnMla7BZO
X-Google-Smtp-Source: AGHT+IFnj7pmp12EWMqSCszNnAa0wxQFW3r2mdwohHjz5I8hZ5mc/pN3FOgQz2lGSAxZBFpr9cbKfQ==
X-Received: by 2002:a17:90a:ce16:b0:297:154e:521d with SMTP id f22-20020a17090ace1600b00297154e521dmr268081pju.42.1707848480317;
        Tue, 13 Feb 2024 10:21:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiVawyW5hBG0m32tHzMP7NoNuMmGVlNoeP68+0f1Wti1lS9Wpq1zchR1HfneQ3r6YkAIy7yrq+q/ppKWT/6EJshysN4OetXYgQxzli8hals9C03FQzjAS1ziaJFr3aq+4UmwBO1xkxKSr1Vxs91OuAXNHE8FuuDq/1SjRAY9bpaBZZx5owdL0lgkIFwsu5xNgrqCIGac5Myl3LL5rYpqq466JR5UzpEWCMWl+XejZC94qGwmpbQJF2rzytFahax46lyLFFy5wYXEy2ADqPSwouT+BRUC0Et7hmHuIOCU8zNK/q7TwZx3xGrtFOd+8dbKFDnPvVViXsPZexvlxBh4F0x1OtHA1mf8Z+r/8h5Ca5Z5cCTKFl+g==
Received: from debian ([2601:641:300:14de:a8fd:e6e0:547f:c54a])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090ae38800b00298b4e896a5sm1563590pjz.46.2024.02.13.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:21:20 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 13 Feb 2024 10:21:17 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, nifan@outlook.com,
	jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 8/9] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Message-ID: <ZcuzHcqn4VeZdSam@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-9-nifan.cxl@gmail.com>
 <20240213174405.00002568@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213174405.00002568@Huawei.com>

On Tue, Feb 13, 2024 at 05:44:05PM +0000, Jonathan Cameron wrote:
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 8cc4c72fa9..6b631f64f1 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -25,7 +25,8 @@
> >    'data': ['informational',
> >             'warning',
> >             'failure',
> > -           'fatal']
> > +           'fatal',
> > +           'dyncap']
> >   }
> Needs a docs update.
> 
> Upstream QEMU seems to have gained some stricter checks
> so this just broke my build after a rebase.
> 
> Jonathan

Thanks. Updated.

FYI. The new version is completed.
https://lore.kernel.org/linux-cxl/ZcuyZ0Nwq31z8YIr@debian/T/#m07b4b4586e2f421a617f08a002b196d932a88966

Thanks,
Fan
