Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C13624A4
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994030; cv=none; b=qojrjkBibEB6l19s+noWJf0Xi1iqMpRWmlxzuYGA5Y6n63FAnzxywuTlI3GlGkHHusJgP07EQXRnkVqvmwM4dKrmBjtDz8Lz2vlJc4Dk8b++8Vp9v4sam3kJq3uoSVs0t0HEAshrAvBVV5ni3tguaLi50MXlQ5R0U8q9vcF47mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994030; c=relaxed/simple;
	bh=cFmtjlApPJMv1ExIyQgS/Wkr5/q9Jg2WVOu3pXR2DIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2IyU51HDaASRNwbttnbmFBwoP1QB3kfZInevK1vlfX7einop5yxZ8WABopCCQkkMxxs+31+Xprr6CBgg/q6Gifg0QY2+FDXHYqyBP36igUwbayd0905z2Bi+phaC+6TxYHeD62XnalqH28GL5zzdtr60zQmFMpHljp80qDZnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U07jB4IZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U07jB4IZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5069ad750b7so9272561cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 06:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770994026; x=1771598826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrAMkqth4z6DpXcsZiO276ItuQcl7/pBA07JwYoUCTM=;
        b=U07jB4IZ9hM11xfW+WW55HSynriJzSkVLtEr9GIJxw44vhGDyjab0vcSe6KdKT3ycL
         UXITyv01HQLPQtajmTE6V8EZHfGr7JJ7c+4PNMUne8kz2mlIt04tlpSnHF9P9cImD6zq
         HCQ6ix7e4FT6bmwHTCQY8JIPNwp2NWV+cMPD+Sb8Kg9eL4fbpAma115AYMlVjI5TUynp
         dmVHW3YkeGQPG9m3KPT0I4THXbyjnvOgfiOge0sTq4cQ8sr1+9JAwv1qeQ++cj1F4g8s
         8EoZZ1YbJpCD0TUk2oFntjdu11NZrockdAQ7wFD7dD4Vx9228flfb3xQJXOK7sGfHY/B
         GYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770994026; x=1771598826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SrAMkqth4z6DpXcsZiO276ItuQcl7/pBA07JwYoUCTM=;
        b=Bm7R+6IxrvZBCXWUvWtIWGCX5VDd30VUZOXxWmOmBlxkV/L5aoWqDRqt/OzUuFaIj4
         EDtwZpQSkZ21Arug+SnfSk0MbKdKTGmcUwX1Ds7zUCx65HrlxGSA6P3Ffae/Gf2IvoLs
         epH0zjnilScFm8P8+Ga8lg8GwdfUCrBYOPt3UOwl4cn6v4rRg46VN0IF7mniUaDaVDYX
         Cs41XpeI3sgcrYBk/AM0M8nsFqlVVP0VmsNxN51pSDVsZtxPpThUEi1hE8+eWdyNRFtN
         GDm5XsSLbBIwnCXkBfYgoCGsUar3SiiGEnVHCKxTf3XkbF/LqOQ4DyAsZIiRnfU4eKVW
         lvIA==
X-Forwarded-Encrypted: i=1; AJvYcCXJc5Y6uAucO8fVjYbGWdknPnLUFNjaoMgzMdDwSvwZl94xVo9hwB8Ab4RQaOhvsMq3VsY/Jm2qA5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kpEOApcY9tXYLS3AQy4wUUWGSaVbkJZnaxAoxRukdGxxCaF1
	hq8vgEFlBXstMUf6qw3PYIveP33sNCAZquIUIxmQW1xvj7VN04P6YyQzV8WoMb5FtPo=
X-Gm-Gg: AZuq6aIGD0bLmr2L07GUEMeRzKSrr7qy+KI8h4GPjCf81pwYLREcmgeyDrYDqBmd9el
	OydLwX+OJy/jwQEmeS/Ko+jYYhzZDKs0I6wy58u0+zGMm3SUcf4eqz5wMpBqi/hmL5WL/IRkDOO
	b5cq0MNc3OAmnbPufbyLSjrnr3YK2y9loZJoP4vrlBHFvT3uABDVlYm9SzhlqDCYGEQt/iFMlEh
	fdGm4TIiClL8wKqrvr3DyO0Hdh5T9xbpeDas2/88AcM4i6aAM4GIU+PUrEm78Quftiya8bJN/C5
	fLF7Epek+sgCte/IHRMuAYVGjUh9OPA/XiVjeWyQwzPkCRAxaFuNAprVwgGg8UsFNNq/XelrFgJ
	qDpay8EN83viQQM0fBo0UgFKUyiBUTnPfJKDyAWWbJB2mWATA+EPMKQnBetszaWML+Smp5igf+j
	nejTnGnurdxMSBT+ek6SK4QNNJQqIxoSDmtfV0AyHi7POKO2KqbJxutQWbEbg6WnCKH3vHNhQ8b
	ucwVBNmMjGxICc=
X-Received: by 2002:a05:622a:589:b0:502:a1c6:4ee with SMTP id d75a77b69052e-506a8271753mr27503871cf.1.1770994026464;
        Fri, 13 Feb 2026 06:47:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7bbcdsm64961446d6.9.2026.02.13.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:47:05 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
Date: Fri, 13 Feb 2026 09:47:00 -0500
Message-ID: <20260213144704.2780265-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
References: <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Feb 10, 2026 at 06:45:00AM +0000, Smita Koralahalli wrote:

This is a review generated by kreview-0811365ff2
Reference: https://github.com/masoncl/review-prompts/

This is not an automated email, I thought this looked valid, the rest of
the text here is auto-generated.

~Gregory

---

[...]

> +static void process_defer_work(void *data)
> +{
> +	struct platform_device *pdev = data;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();

[...]

> +static void kill_defer_work(void *data)
> +{
> +	struct platform_device *pdev = data;
> +
> +	dax_hmem_flush_work();
> +	dax_hmem_unregister_work(process_defer_work, pdev);
> +}
> +
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> +	int rc;
> +
> +	rc = dax_hmem_register_work(process_defer_work, pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, pdev);
> +	if (rc)
> +		return rc;
> +
>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>  }

Is there a potential deadlock in the error path here? If
walk_hmem_resources() encounters a CXL-intersecting range first
(calling dax_hmem_queue_work(), which schedules process_defer_work
on system_long_wq), and then a subsequent non-CXL Soft Reserved
range fails to register, the probe returns an error. The devres
cleanup then calls kill_defer_work -> dax_hmem_flush_work() ->
flush_work(&dax_hmem_work).

Meanwhile, process_defer_work calls wait_for_device_probe(), which
waits for probe_count to reach zero. Since devres_release_all runs
inside really_probe before driver_probe_device decrements
probe_count, this looks like a circular wait:

  driver_probe_device
    atomic_inc(&probe_count)
    __driver_probe_device
      really_probe
        dax_hmem_platform_probe
          walk_hmem_resources -> hmem_register_device
            CXL range: dax_hmem_queue_work()
            non-CXL range: fails
          returns error
        devres_release_all
          kill_defer_work
            dax_hmem_flush_work
              flush_work(&dax_hmem_work)  <-- waits for process_defer_work
                process_defer_work
                  wait_for_device_probe() <-- waits for probe_count == 0
    atomic_dec(&probe_count)              <-- never reached

The trigger requires both CXL-intersecting and non-CXL Soft Reserved
ranges with the non-CXL registration failing, so the window is narrow,
but the deadlock would be permanent if hit.

Would it be safer to cancel the work instead of flushing it in the
error path, or to avoid queuing deferred work during the initial
walk?
